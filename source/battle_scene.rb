class BattleScene

  attr_accessor :battle_area, :player_bullets
  
  class << self
    attr_accessor :instance
  end

  def initialize
    @player_bullets = []
    @enemy_bullets = []
    @battle_area = [Vector[0,0], Vector[550,600]]
    @score_area = [Vector[550,0], Vector[800,600]]
    @player = ReimuPlayer.new @battle_area
    @enemy = Yousei4.new
  end

  def update
    @player.update
    @player_bullets.map &:update
    @player_bullets.select! &:alive?
    @enemy.update
  end

  def draw
    Gosu.draw_rect(*@battle_area[0], *@battle_area[1], Gosu::Color::WHITE)
    Gosu.draw_rect(*@score_area[0], *@score_area[1], Gosu::Color::BLACK)
    @player.draw
    @player_bullets.map &:draw
    @enemy.draw
  end

  def add_bullet bullet, from
    if from == :player
      @player_bullets << bullet
    end
    
  end
end