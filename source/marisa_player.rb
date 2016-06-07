class MarisaPlayer < Player
  def initialize battle_area
    super 'marisa', battle_area
    @normal_speed = 5
    @slow_speed = 3
    @bullet_fatories = []
  end
end