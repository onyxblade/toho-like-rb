class ReimuBullet1 < Bullet
  include Helpers

  class << self
    attr_accessor :image
  end

  def initialize position, velocity
    super()
    self.class.image ||= Gosu::Image.new("image/pl_shot.png", rect: [34, 129, 13, 50])
    @width = 13
    @height = 50
    @position = position
    @velocity = velocity
    @speed = 25
    @demage = 10
  end

  def draw
    draw_indicator *@position
    self.class.image.draw *canvas_position, 0, 1, 1, 0x99ffffff
  end

  def canvas_position
    Vector[@position[0] - @width / 2, @position[1]]
  end

  def hit? center, r
    (center[0] - @position[0]) ** 2 + (center[1] - @position[1]) ** 2 < r ** 2
  end
end