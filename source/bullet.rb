class Bullet
  attr_accessor :position, :alive, :demage
  prepend Behavior
  include Moveable

  def initialize params={}, &block
    @alive = true

    @acceleration = Vector[0, 0]
    @velocity = Vector[0, 0]
    @position = Vector[0, 0]

    set params if !params.empty?
    initialize_sprite
  end

  def update
    update_velocity
    update_position

    if out_of_area?
      @alive = false
    end

  end

  def alive?
    @alive
  end

  def out_of_area?
    @dead_distance ||= [@height, @width].max

    battle_area.x1 - @position.x > @dead_distance ||
    battle_area.x2 - @position.x < @dead_distance ||
    battle_area.y1 - @position.y > @dead_distance ||
    battle_area.y2 - @position.y < @dead_distance
  end

  def update_velocity
    @velocity += @acceleration
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