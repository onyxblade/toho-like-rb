class Bullet
  attr_accessor :position, :alive, :demage
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

    initialize_sprite
  end

  def update
    @behavior.next

    update_velocity
    update_position

    if out_of_area?
      @alive = false
    end

  end

  def alive?
    @alive
  end

  def tracing?
    @tracing
  end

  def out_of_area?
    @dead_distance ||= [@height, @width].max

    battle_area.x1 - @position.x > @dead_distance ||
    battle_area.x2 - @position.x < @dead_distance ||
    battle_area.y1 - @position.y > @dead_distance ||
    battle_area.y2 - @position.y < @dead_distance
  end

  def update_velocity
    @speed += @acceleration
    if tracing?
      @turning_direction = @target_position - @position
      @turning_speed += @turning_acceleration
      @turning_velocity = @turning_direction * @turning_speed
      @velocity = (@velocity.normalize + @turning_velocity.normalize) * @speed
    else
      @velocity = @velocity.normalize * @speed
    end
  end

  def update_position
    @position += @velocity
  end

  def display_direction
    Gosu.angle(0, 0, *@velocity)
  end

  def hitted _
    @alive = false
    #battle_scene.effects << ShockWave.new(*@position)
  end
end