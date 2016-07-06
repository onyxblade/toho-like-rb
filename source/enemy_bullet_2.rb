class EnemyBullet2 < Bullet
  class << self
    attr_accessor :images
  end

  def initialize params = {}, &block
    super(params, &block)
    initialize_sprite
    @color = :yellow
    @image = self.class.images[0]
    set params
  end

  def initialize_sprite
    self.class.images ||= [Gosu::Image.new('image/bullet.png', rect: [212, 96, 8, 16]), Gosu::Image.new('image/bullet.png', rect: [132, 96, 8, 16])]
    @width = 8
    @height = 16
  end

  def update
    case @color
    when :yellow
      @image = self.class.images[0]
    when :blue
      @image = self.class.images[1]
    end
    super
  end

  def draw
    @image.draw_rot(*@position, 0, display_direction)
  end

  def collision_body
    [@position, 4]
  end
end