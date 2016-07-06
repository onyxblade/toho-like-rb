class Background
  def initialize(area)
    @area = area
    @image = Gosu::Image.new('image/bg1.png')
    @width = @image.width
    @height = @image.height
    @position = @area[0]
    @velocity = Vector[0, 2]
  end

  def update
    @position += @velocity
    @position = Vector[@position.x, @position.y % @height]
  end

  def draw
    @image.draw(*@position, -1)
    @image.draw(@position.x + @width, @position.y, -1)
    @image.draw(@position.x + @width, @position.y + @height, -1)
    @image.draw(@position.x, @position.y + @height, -1)
    @image.draw(@position.x, @position.y - @height, -1)
    @image.draw(@position.x + @width, @position.y - @height, -1)
  end
end