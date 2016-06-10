class Player
  include Helpers

  attr_accessor :pos

  ANIMATE_SPEED = 4
  STATE = [:moving_left, :moving_right, :normal, :slow]

  def initialize character, battle_area
    @moveable_area = battle_area
    @position = Vector[270, 576]
    @height = 48
    @width = 32
    @speed = @normal_speed
    @normal = Animation.new do
      images = 8.times.map do |i|
        Gosu::Image.new("image/#{character}.png", rect: [32*i, 0, 32, 48])
      end

      lambda do |enum|
        loop {
          images.each do |i|
            ANIMATE_SPEED.times {enum.yield i}
          end
        }
      end
    end

    @move_left = Animation.new do
      images = 8.times.map do |i|
        Gosu::Image.new("image/#{character}.png", rect: [32*i, 48, 32, 48])
      end

      lambda do |enum|
        loop{
          images.last(4).each do |i|
            ANIMATE_SPEED.times { enum.yield i }
          end
        }
      end

    end

    @move_right = Animation.new do
      images = 8.times.map do |i|
        Gosu::Image.new("image/#{character}.png", rect: [32*i, 96, 32, 48])
      end

      lambda do |enum|
        loop {
          images.last(4).each do |i|
            ANIMATE_SPEED.times { enum.yield i }
          end
        }
      end
    end

    @animation = @normal

  end

  def update
    update_speed
    process_move
    @bullet_factories.map &:update
    process_fire
  end

  def draw
    draw_indicator *@position
    image = @animation.next
    image.draw(*canvas_position, 0)
    @bullet_factories.map &:draw
  end

  def move pos
    pos = Vector[*pos].normalize * @speed
    @position += pos

    force_in_area @moveable_area
  end

  def process_move
    direction = Vector[0, 0]
    last_moving = @moving
    if Gosu::button_down? Gosu::KbLeft
      direction += Vector[-1, 0]
      moving = :left
    end
    if Gosu::button_down? Gosu::KbRight
      direction += Vector[+1, 0]
      moving = :right
    end
    if Gosu::button_down? Gosu::KbUp
      direction += Vector[0, -1]
    end
    if Gosu::button_down? Gosu::KbDown
      direction += Vector[0, +1]
    end
    if moving != last_moving
      case moving
      when :left
        @animation = @move_left
      when :right
        @animation = @move_right
      when nil
        @animation = @normal
      end
    end
    @moving = moving
    move direction unless direction.magnitude == 0
  end

  def update_speed
    if Gosu::button_down? Gosu::KbLeftShift
      @speed = @slow_speed
    else
      @speed = @normal_speed
    end
  end

  def force_in_area area
    if canvas_position[0] < area[0][0]
      x = area[0][0]
    end
    if canvas_position[1] < area[0][1]
      y = area[0][1]
    end
    if canvas_position[0] + @width > area[1][0]
      x = area[1][0] - @width
    end
    if canvas_position[1] + @height > area[1][1]
      y = area[1][1] - @height
    end
    cpos = Vector[x || canvas_position[0], y || canvas_position[1]]
    @position = calc_actual_position cpos
  end

  def process_fire
    if Gosu::button_down? Gosu::KbZ
      @bullet_factories.map &:process_fire
    end
  end

  def canvas_position
    Vector[@position[0] - @width / 2, @position[1] - @height / 2]
  end

  def calc_actual_position canvas_position
    Vector[canvas_position[0] + @width / 2, canvas_position[1] + @height / 2]
  end
end