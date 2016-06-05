class Player
  include Helpers

  attr_accessor :pos

  NORMAL_SPEED = 5
  SLOW_SPEED = 2
  ANIMATE_SPEED = 4
  STATE = [:moving_left, :moving_right, :normal, :slow]

  def initialize(character, moveable_area)
    @moveable_area = moveable_area
    @position = Vector[0, 0]
    @height = 48
    @width = 32
    @speed = NORMAL_SPEED
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
    process_fire
  end

  def draw
    image = @animation.next
    image.draw(*@position, 0)
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
      @speed = SLOW_SPEED
    else
      @speed = NORMAL_SPEED
    end
  end

  def force_in_area area
    if @position[0] < area[0][0]
      x = area[0][0]
    end
    if @position[1] < area[0][1]
      y = area[0][1]
    end
    if @position[0] + @width > area[1][0]
      x = area[1][0] - @width
    end
    if @position[1] + @height > area[1][1]
      y = area[1][1] - @height
    end
    @position = Vector[x || @position[0], y || @position[1]]
  end

  def process_fire
    if Gosu::button_down? Gosu::KbZ
      battle_scene.add_bullet Bullet.new(@position, Vector[0, -30])
    end
  end
end