class Enemy

  attr_accessor :position

  def initialize
    @alive = true
    @behavior = Enumerator.new {|enum| loop{ enum.yield }}
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
    apply_behavior

  end

  def apply_behavior
    @behavior.next&.each{|key, value| instance_variable_set("@#{key}", value)}
  end

end