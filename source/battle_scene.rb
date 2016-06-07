class BattleScene

  attr_accessor :battle_area
  
  class << self
    attr_accessor :instance
  end

  def initialize
    @bullets = []
    @battle_area = [Vector[0,0], Vector[550,600]]
    @score_area = [Vector[550,0], Vector[800,600]]
    @player = ReimuPlayer.new @battle_area
  end

  def update
    @player.update
    @bullets.map &:update
    @bullets.select! &:alive?
  end

  def draw
    Gosu.draw_rect(*@battle_area[0], *@battle_area[1], Gosu::Color::WHITE)
    Gosu.draw_rect(*@score_area[0], *@score_area[1], Gosu::Color::BLACK)
    @player.draw
    @bullets.map &:draw
  end

  def add_bullet bullet
    @bullets << bullet
  end
end