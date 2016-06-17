class ReimuBullet2 < Bullet

  attr_accessor :demage

  class << self
    attr_accessor :image
  end

  def initialize position
    super()
    self.class.image ||= Gosu::Image.new("image/pl_shot.png", rect: [18, 242, 12, 13])
    @position = position
    @target = Vector[300,300]
    @speed = 15
    @velocity = Vector[0, -1]
    @demage = 25
    @acceleration = 0
  end

  def draw
    draw_indicator *@position
    self.class.image.draw_rot *@position, 0, calc_direction, 0.5, 0.0, 1, 1, 0x99ffffff
  end

  def alive?
    @alive
  end

  def hit? center, r
    (center[0] - @position[0]) ** 2 + (center[1] - @position[1]) ** 2 < r ** 2
  end

  def update_velocity
    rotate_velocity = (@target - @position).normalize * 1
    @velocity = (@velocity.normalize + rotate_velocity) * @speed
  end
end