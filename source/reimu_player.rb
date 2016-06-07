class ReimuPlayer < Player
  def initialize battle_area
    super 'reimu', battle_area
    @normal_speed = 5
    @slow_speed = 3
    @bullet_factories = [ReimuMainBulletFactory.new(3){ @position }, ReimuAssistBulletFactory.new(3){ @position }]
  end
end