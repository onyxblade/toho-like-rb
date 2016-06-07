class ReimuBullet1 < Bullet
  def initialize position, velocity
    super()
    @@image ||= Gosu::Image.new("image/pl_shot.png", rect: [34, 129, 13, 50])
    @width = 13
    @height = 50
    @position = position
    @velocity = velocity
    @speed = 25
    @demage = 10
  end

  def draw
    @@image.draw *canvas_position, 0, 1, 1, 0x99ffffff
  end

  def canvas_position
    Vector[@position[0] - @width / 2, @position[1] - @height / 2]
  end
end