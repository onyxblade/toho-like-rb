class EnemyBullet1 < NewBullet
  class << self
    attr_accessor :image
  end

  def initialize &block
    super(&block)
    initialize_sprite
  end

  def initialize_sprite
    self.class.image ||= Gosu::Image.new('image/bullet.png', rect: [128, 48, 16, 16])
    @width = 16
    @height = 16
  end

  def draw
    self.class.image.draw_rot(*@position, 0, 0)
  end

  def collision_body
    [@position, 8]
  end
end