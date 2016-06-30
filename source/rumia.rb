class Rumia < Boss
  def initialize params = {}, &block
    super(&block)
    initialize_sprite
    @state = :normal
    @hp = 10000
    @life = 3
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
    case @state
    when :moving_left
      @image = @moving_left.next
    when :moving_right
      @image = @moving_right.next
    when :normal
      @image = @normal.next
    end
    super
  end

  def draw
    @image.draw_rot(*@position, 0, 0)
  end
end