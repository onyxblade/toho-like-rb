class Yousei1 < Enemy
  class << self
    attr_accessor :images
  end

  ANIMATE_SPEED = 8

  def initialize
    super()
    initialize_sprite

    @hp = 20
  end

  def initialize_sprite
    self.class.images ||= 3.times.map do |i|
      Gosu::Image.new("image/enemy.png", rect: [32*i, 0, 32, 30])
    end
    @animation = Enumerator.new do |enum|
      loop {
        self.class.images.each do |i|
          ANIMATE_SPEED.times {enum.yield i}
        end
      }
    end
    @width = 32
    @height = 30
  end

  def update

  end

  def draw
    @image = @animation.next
    @image.draw(300, 300, 1)
  end
end