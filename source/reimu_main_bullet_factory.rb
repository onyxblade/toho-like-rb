class ReimuMainBulletFactory < BulletFactory
  def initialize level, &block
    super(&block)
    @level = level
    @interval = 3
    @velocity = Vector[0, -25]
    @speed = 25

    set_level_detail
  end

  def create_bullet
    position = @position_proc.call
    position = Vector[position[0], position[1]-5]
    case @level
    when 1
      [
        ReimuBullet1.new do
          set position: position,
              velocity: @velocity
        end
      ]
    when 2
      seperation = @slow ? 0.35 : 1
      [
        ReimuBullet1.new do
          set position: Vector[position[0]-3, position[1]],
              velocity: Vector[-seperation, -25]
        end,
        ReimuBullet1.new do
          set position: Vector[position[0]+3, position[1]],
              velocity: Vector[seperation, -25]
        end
      ]
    when 3
      seperation = @slow ? 0.7 : 2
      [
        ReimuBullet1.new do
          set position: Vector[position[0]-3, position[1]],
              velocity: Vector[-seperation, -25]
        end,
        ReimuBullet1.new do
          set position: Vector[position[0]+3, position[1]],
              velocity: Vector[seperation, -25]

        end,
        ReimuBullet1.new do
          set position: Vector[position[0], position[1]],
              velocity: Vector[0, -25]
        end
      ]
    end
  end

  def set_level_detail
    case @level
    when 1

    when 2

    when 3

    end
  end

  def update
    super
    @slow = Gosu::button_down? Gosu::KbLeftShift
  end
end