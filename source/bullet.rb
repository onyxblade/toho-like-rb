class Bullet
  include Helpers

  def initialize
    @alive = true
  end

  def update
    @position = @position + @velocity
    if !in_area?
      @alive = false
    end
  end

  def draw
    @image.draw(*@position, 0, 1, 1, 0x99ffffff)
  end

  def alive?
    @alive
  end

  def in_area? 
    canvas_position[0] > battle_area[0][0] &&
      canvas_position[1] > battle_area[0][1] &&
      canvas_position[0] + @width < battle_area[1][0] &&
      canvas_position[1] + @height < battle_area[1][1]
  end

  def canvas_position
  end
end