class Rumia < Boss
  def initialize params = {}, &block
    super(&block)
    initialize_sprite
    @state = :normal
    @hp = 1500
    @total_hp = 1500
    @life = 3
    update_direction
  end

  def initialize_sprite
    @images =
      6.times.map do |x|
        4.times.map do |y|
          Gosu::Image.new('image/rumia.png', rect: [x*128, y*128, 128, 128])
        end
      end
    @moving_left = Enumerator.new do |enum|
      loop{ enum.yield @images[2][1] }
    end
    @moving_right = Enumerator.new do |enum|
      loop{ enum.yield @images[2][3]}
    end
    @normal = Enumerator.new do |enum|
      loop{
        4.times do |i|
          4.times{ enum.yield @images[0][i] }
        end
      }
    end
    @height = 58
    @width = 45
  end

  def update
    super
    update_direction

    if @hp < 0
      @alive = false
      @@dead_se.play
      battle_scene.effects << ShockWave.new(@position)
    end
  end

  def update_direction
    case
    when @velocity.x < 0
      @state = :moving_left
    when @velocity.x > 0
      @state = :moving_right
    else
      @state = :normal
    end
    case @state
    when :moving_left
      @image = @moving_left.next
    when :moving_right
      @image = @moving_right.next
    when :normal
      @image = @normal.next
    end
  end

  def draw
    super
    @image.draw_rot(*@position, 0, 0)
  end

end