class Enemy4 < Enemy
  class << self
    attr_accessor :images
  end

  ANIMATE_SPEED = 8

  def initialize position
    super()
    initialize_sprite

    @behavior = Enumerator.new do |enum|
      enum.yield(
        position: position,
        velocity: Vector[0, -1],
        speed: 25
      )

      loop{ enum.yield }
    end
    @behavior.next.each{|key, value| instance_variable_set("@#{key}", value)}

    @position = position
    @r = @width / 2
    @hp = 100
  end

  def initialize_sprite
    self.class.images ||= 3.times.map do |i|
      Gosu::Image.new("image/enemy.png", rect: [64*i, 230, 64, 49])
    end
    @animation = Enumerator.new do |enum|
      loop {
        self.class.images.each do |i|
          ANIMATE_SPEED.times {enum.yield i}
        end
      }
    end
    @width = 64
    @height = 49
  end

  def collision_body
    [@position, @r]
  end

  def update
    super
    @position += @velocity
  end

  def canvas_position
    Vector[@position[0] - @width / 2, @position[1] - @height / 2]
  end

  def draw
    draw_indicator(*@position)
    draw_indicator(@position[0] - @r, @position[1])
    @image = @animation.next
    @image.draw(*canvas_position, 1)
  end
end