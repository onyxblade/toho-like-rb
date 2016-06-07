class ReimuAssistBulletFactory < BulletFactory
  def initialize level, &block
    super &block
    @@image ||= Gosu::Image.new 'image/reimu_option.png'
    @rotation_a = 0
    @rotation_b = 90
    @interval = 1
  end

  def update
    @rotation_a += 5
    @rotation_b -= 5
  end

  def draw
    position = @position_proc.call
    @@image.draw_rot(position[0]+25, position[1], 0, @rotation_a, 0.5, 0.5, 1, 1, 0xaaffffff)
    @@image.draw_rot(position[0]-25, position[1], 0, @rotation_b, 0.5, 0.5, 1, 1, 0xaaffffff)
  end

  def create_bullet
    []
  end
end