class Enemy

  attr_accessor :position

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

end