class Enemy

  attr_accessor :position
  prepend Behavior
  include Moveable

  def initialize params = {}
    @alive = true

    @position = Vector[0, 0]
    @acceleration = Vector[0, 0]
    @velocity = Vector[0, 0]

    @@dead_se ||= Gosu::Sample.new('SE/enemy_vanish.wav')
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
      @@dead_se.play
      battle_scene.effects << ShockWave.new(@position)
    end
  end

  def update
    update_velocity
    update_position

    if out_of_area?
      @alive = false
    end
  end

  def update_velocity
    @velocity += @acceleration
  end

  def update_position
    @position += @velocity
  end

  def collision_body
    [@position, @width/2]
  end

  def out_of_area?
    @dead_distance ||= [@height, @width].max

    battle_area.x1 - @position.x > @dead_distance ||
    battle_area.x2 - @position.x < -@dead_distance ||
    battle_area.y1 - @position.y > @dead_distance ||
    battle_area.y2 - @position.y < -@dead_distance
  end

end