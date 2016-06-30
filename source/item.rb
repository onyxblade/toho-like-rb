class Item

  class << self
    attr_accessor :images, :se
  end

  def initialize type, position
    @alive = true
    @position = position
    self.class.images ||= [Gosu::Image.new('image/power_item.png'), Gosu::Image.new('image/score_item.png')]
    self.class.se ||= Gosu::Sample.new('SE/graze.wav')
    case type
    when :power
      @image = self.class.images[0]
    when :score
      @image = self.class.images[1]
    end
    @velocity = Vector[0, -2]
    @acceleration = Vector[0, 0.03]
    @width = 12
    @height = 12
  end

  def update
    @velocity += @acceleration
    @position += @velocity
  end

  def draw
    @image.draw_rot(*@position, 0, 0)
  end

  def alive?
    @alive
  end

  def collision_body
    [@position, @width / 2]
  end

  def picked_by player
    case @type
    when :power
      player.power += 5
    when :score
      player.score += 5
    end
    @alive = false
    self.class.se.play
  end
end