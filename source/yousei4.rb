class Yousei4 < Enemy
  class << self
    attr_accessor :images
  end

  ANIMATE_SPEED = 8

  def initialize
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
    @position = Vector[300,300]
    @width = 64
    @height = 49
    @r = @width / 2
    @hp = 100000
  end

  def update
    battle_scene.player_bullets.each do |x|
      if x.alive? && x.hit?(@position, @r)
        x.alive = false
        @hp -= x.demage
        p @hp
      end
    end
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