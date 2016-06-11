class Yousei3 < Enemy
  class << self
    attr_accessor :images
  end

  ANIMATE_SPEED = 8

  def initialize
    self.class.images ||= 3.times.map do |i|
      Gosu::Image.new("image/enemy.png", rect: [48*i, 132, 48, 39])
    end
    @animation = Enumerator.new do |enum|
      loop {
        self.class.images.each do |i|
          ANIMATE_SPEED.times {enum.yield i}
        end
      }
    end

    @width = 48
    @height = 39

  end

  def update

  end

  def draw
    @image = @animation.next
    @image.draw(300, 300, 1)
  end
end