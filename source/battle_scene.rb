class BattleScene

  attr_accessor :battle_area, :score_area, :player_bullets, :enemies, :enemy_bullets, :effects, :items
  
  class << self
    attr_accessor :instance
  end

  def initialize
    @player_bullets = []
    @enemy_bullets = []
    @enemies = []
    @effects = []
    @items = []

    @battle_area = Rect[[0,0], [550,600]]
    @score_area = Rect[[550,0], [800,600]]
    @player = ReimuPlayer.new @battle_area
    @enemies << Yousei4.new

    @font = Gosu::Font.new(20)
  end

  def update
    @player.update
    @player_bullets.map &:update
    @player_bullets.select! &:alive?
    @enemies.map &:update
    @enemy_bullets.map &:update
    @enemy_bullets.select! &:alive?
    @effects.map &:update
    @effects.select! &:alive?
    @items.map &:update
    @items.map &:alive?

  end

  def draw
    Gosu.draw_rect(*@battle_area[0], *@battle_area[1], Gosu::Color::WHITE)
    Gosu.draw_rect(*@score_area[0], *@score_area[1], Gosu::Color::BLACK)
    @player.draw
    @player_bullets.map &:draw
    @enemies.map &:draw
    @enemy_bullets.map &:draw
    @effects.map &:draw
    @items.map &:draw
    @font.draw("Bullets: #{@player_bullets.count + @enemy_bullets.count}", *@score_area.relative(10, 10), 1, 1.0, 1.0, 0xff_ffffff)
  end

  def add_bullet bullet, from
    if from == :player
      @player_bullets << bullet
    else
      @enemy_bullets << bullet
    end
  end
end