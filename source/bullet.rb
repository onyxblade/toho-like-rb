class Bullet
  attr_accessor :position, :alive, :demage
  def initialize
    @alive = true
  end

  def update
    update_velocity
    update_position

    update_alive
  end

  def draw

  end

  def alive?
    @alive
  end

  def canvas_position

  end

  def update_velocity

  end

  def update_position
    @position = @position + @velocity
  end

  def update_alive

  end
end