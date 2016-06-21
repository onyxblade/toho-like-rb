class ReimuBullet2 < Bullet

  attr_accessor :demage

  class << self
    attr_accessor :image
  end

  def initialize position
    super()
    @tracing = true
    @position = position
    @speed = 15
    @velocity = Vector[0, -1]
    @demage = 25
    @acceleration = 0
    @turning_speed = 1
    initialize_behavior{}
  end

  def initialize_sprite
    self.class.image ||= Gosu::Image.new("image/pl_shot.png", rect: [18, 242, 12, 13])
    @width = 12
    @height = 13
  end

  def update
    if !@target&.alive?
      @target = find_target
    end
    if @target
      @target_position = @target.position
      @tracing = true
    else
      @tracing = false
    end
    super
  end

  def find_target
    battle_scene.enemies.min_by{|x| (x.position - @position).r }
  end

  def draw
    draw_indicator *@position
    self.class.image.draw_rot *@position, 0, display_direction, 0.5, 0.0, 1, 1, 0x99ffffff
  end

  def collision_body
    [@position, 0]
  end
end