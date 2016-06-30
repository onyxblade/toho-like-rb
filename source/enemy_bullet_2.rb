class EnemyBullet2 < NewBullet
  class << self
    attr_accessor :image
  end

  def initialize params = {}, &block
    super(params, &block)
    initialize_sprite

    set params
  end

  def initialize_sprite
    self.class.image ||= Gosu::Image.new('image/bullet.png', rect: [212, 96, 8, 16])
    @width = 8
    @height = 16
  end

  def draw
    self.class.image.draw_rot(*@position, 0, display_direction)
  end

  def collision_body
    [@position, 4]
  end
end