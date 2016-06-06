class ReimuMainBulletFactory < BulletFactory
  def initialize level, &block
    super(&block)
    @level = level
    @interval = 3
    @velocity = Vector[0, -25]
  end

  def create_bullet
    case @level
    when 1
      [ReimuBullet1.new(@position_proc.call, @velocity)]
    when 2
      [
        ReimuBullet1.new(@position_proc.call, Vector[-1, -25]),
        ReimuBullet1.new(@position_proc.call, Vector[1, -25])
      ]
    when 3
      [
        ReimuBullet1.new(@position_proc.call, Vector[-1.5, -25]),
        ReimuBullet1.new(@position_proc.call, Vector[1.5, -25]),
        ReimuBullet1.new(@position_proc.call, Vector[0, -25])
      ]
    end
  end

end