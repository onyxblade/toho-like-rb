class Enemy

  attr_accessor :position
  include Behavior

  def initialize
    @alive = true

    @tracing = false
    @position = Vector[0, 0]
    @speed = 0
    @acceleration = 0
    @turning_speed = 0
    @turning_acceleration = 0
    @velocity = Vector[0, 0]
    @turning_direction = Vector[0, 0]
  end

  def alive?
    @alive
  end

  def tracing?
    @tracing
  end

  def hitted_by bullet
    @hp -= bullet.demage
    if @hp < 0
      @alive = false
      battle_scene.effects << ShockWave.new(@position)
    end
  end

  def update
    @behavior.next

    update_velocity
    update_position
  end

  def update_velocity
    @speed += @acceleration
    if tracing?
      @turning_direction = @target_position - @position
      @turning_speed += @turning_acceleration
      @turning_velocity = @turning_direction.normalize * @turning_speed
      @velocity = (@velocity + @turning_velocity).normalize * @speed
    else
      @velocity = @velocity.normalize * @speed
    end
  end

  def update_position
    @position += @velocity
  end

  def collision_body
    [@position, @width/2]
  end

end