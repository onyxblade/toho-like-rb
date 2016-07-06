class ReimuBullet2 < Bullet

  attr_accessor :demage

  class << self
    attr_accessor :image
  end

  def initialize position
    super()
    @tracing = true
    @position = position
    @speed = 9
    @velocity = Vector[0, -1]
    @demage = 25
    @acceleration = 0
    @turning_speed = 1
    @turning_acceleration = 2
  end

  def initialize_sprite
    self.class.image ||= Gosu::Image.new("image/pl_shot.png", rect: [18, 242, 12, 13])
    @width = 12
    @height = 13
  end

  def tracing?
    @tracing
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

    @speed += @acceleration
    if tracing?
      @turning_direction = @target_position - @position
      @turning_speed += @turning_acceleration
      @turning_velocity = @turning_direction * @turning_speed
      @velocity = (@velocity.normalize + @turning_velocity.normalize) * @speed
    else
      @velocity = @velocity.normalize * @speed
    end
    update_position
  end

  def find_target
    battle_scene.enemies.min_by{|x| (x.position - @position).r }
  end

  def draw
    draw_indicator *@position
    self.class.image.draw_rot *@position, 0, display_direction, 0.5, 0.0, 1, 1, 0xccffffff
  end

  def collision_body
    [@position, 0]
  end
end