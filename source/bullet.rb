class Bullet
  def initialize pos, speed
    @image = Gosu::Image.new("image/pl_shot.png", rect: [34, 129, 13, 50])
    @position = pos
    @speed = speed
    @alive = true
  end

  def update
    @position = @position + @speed
    if @position.any? {|x| x < 0}
      @alive = false
    end
  end

  def draw
    @image.draw(*@position,0)
  end

  def alive?
    @alive
  end
end