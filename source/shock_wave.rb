class ShockWave
  class << self
    attr_accessor :image
  end

  def initialize position
    self.class.image ||= Gosu::Image.new('image/shockwave.png')
    @position = position
    @scale_enumerator = (0..0.7).step(1.0 / 8)
    @scale = @scale_enumerator.next
    @alive = true
  end

  def update
    @scale = @scale_enumerator.next
  rescue
    @alive = false
  end

  def draw
    self.class.image.draw_rot *@position, 1, 0, 0.5, 0.5, @scale, @scale
  end

  def alive?
    @alive
  end
end