class Enemy

  attr_accessor :position
  include Behavior

  def initialize
    @alive = true
  end

  def alive?
    @alive
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

  end

  def update_position
    @position += @velocity
  end

  def collision_body
    [@position, @width/2]
  end

end