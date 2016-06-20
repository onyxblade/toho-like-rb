class ReimuBullet2 < Bullet

  attr_accessor :demage

  class << self
    attr_accessor :image
  end

  def initialize position
    super()
    self.class.image ||= Gosu::Image.new("image/pl_shot.png", rect: [18, 242, 12, 13])
    @position = position
    @width = 12
    @height = 13
    #@target = battle_scene.enemies.last
    @speed = 15
    @velocity = Vector[0, -1]
    @demage = 25
    @acceleration = 0
    @dead_distance = [@height, @width].max
  end

  def update
    if !@target&.alive?
      @target = find_target
    end
    super
  end

  def find_target
    battle_scene.enemies.min_by{|x| (x.position - @position).r }
  end

  def draw
    draw_indicator *@position
    self.class.image.draw_rot *@position, 0, calc_direction, 0.5, 0.0, 1, 1, 0x99ffffff
  end

  def alive?
    @alive
  end

  def hit? center, r
    (center[0] - @position[0]) ** 2 + (center[1] - @position[1]) ** 2 < r ** 2
  end

  def collision_body
    [@position, 0]
  end

  def in_area?
    out =
      battle_area.x1 - @position.x > @dead_distance ||
      battle_area.x2 - @position.x < @dead_distance ||
      battle_area.y1 - @position.y > @dead_distance ||
      battle_area.y2 - @position.y < @dead_distance
    !out
  end

  def update_velocity
    if @target
      rotate_velocity = (@target.position - @position).normalize * 1
    else
      rotate_velocity = Vector[0, 0]
    end
    @velocity = (@velocity.normalize + rotate_velocity) * @speed
  end

  def update_alive
    if !in_area?
      @alive = false
    end
  end
end