class ReimuBullet1 < Bullet

  class << self
    attr_accessor :image
  end

  def initialize position, velocity
    super()
    self.class.image ||= Gosu::Image.new("image/pl_shot.png", rect: [34, 129, 13, 50])
    @width = 13
    @height = 50
    @dead_distance = [@height, @width].max

    @attr_enum = Enumerator.new do |enum|
      enum.yield(
        position: position,
        velocity: velocity,
        speed: 25,
        demage: 10,
      )

      loop{ enum.yield }
    end
    @attr_enum.next.each{|key, value| instance_variable_set("@#{key}", value)}
  end

  def update
    super
    @attr_enum.next&.each{|key, value| instance_variable_set("@#{key}", value)}
  end

  def draw
    draw_indicator *@position
    self.class.image.draw_rot *@position, 0, calc_direction, 0.5, 0.0, 1, 1, 0x99ffffff
  end

  def canvas_position
    Vector[@position[0] - @width / 2, @position[1]]
  end

  def hit? center, r
    (center[0] - @position[0]) ** 2 + (center[1] - @position[1]) ** 2 < r ** 2
  end

  def in_area?
    out =
      battle_area.x1 - @position.x > @dead_distance ||
      battle_area.x2 - @position.x < @dead_distance ||
      battle_area.y1 - @position.y > @dead_distance ||
      battle_area.y2 - @position.y < @dead_distance
    !out
  end

  def update_alive
    if !in_area?
      @alive = false
    end
  end
end