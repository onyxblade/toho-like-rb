class Player
  def initialize
    @image = Gosu::Image.new('image/reimu.png', rect: [0, 0, 30, 48])
    @pos = Vector[0, 0]
  end

  def update

  end

  def draw
    @image.draw(*@pos, 0)
  end

  def move pos
    pos = Vector[*pos].normalize
    @pos += pos
  end
end