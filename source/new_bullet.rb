class NewBullet < Bullet
  def initialize
    super

    @acceleration = Vector[0, 0]
    @velocity = Vector[0, 0]
    @position = Vector[0, 0]
  end

  def update_velocity
    @velocity += @acceleration
  end

  def update_position
    @position += @velocity
  end
end