class BattleScene

  attr_accessor :battle_area, :score_area, :player_bullets, :enemies, :enemy_bullets, :effects, :items, :presenters, :boss

  class << self
    attr_accessor :instance
  end

  def initialize character
    @player_bullets = []
    @enemy_bullets = []
    @enemies = []
    @effects = []
    @items = []
    @presenters = []
    @boss = nil

    @battle_area = Rect[[0,0], [550,600]]
    @score_area = Rect[[550,0], [800,600]]

    case character
    when 'reimu'
      @player = ReimuPlayer.new @battle_area
    when 'marisa'
      @player = MarisaPlayer.new @battle_area
    end

    @enemies << Enemy4.new(Vector[300,300])
    @enemies << Enemy4.new(Vector[500,300])

    @font = Gosu::Font.new(20)

    @stage = Stage1.new
    #@items << Item.new(:power, Vector[100, 100])
  end

  def update
    @player.update

    process_collisions

    @player_bullets.select! &:alive?
    @player_bullets.map &:update
    @enemies.select! &:alive?
    @enemies.map &:update
    @enemy_bullets.select! &:alive?
    @enemy_bullets.map &:update
    @effects.select! &:alive?
    @effects.map &:update
    @items.select! &:alive?
    @items.map &:update
    @presenters.select! &:alive?
    @presenters.map &:update

    @stage.update
    @boss&.update
  end

  def draw
    Gosu.draw_rect(*@battle_area[0], *@battle_area[1], Gosu::Color::WHITE)
    Gosu.draw_rect(*@score_area[0], *@score_area[1], Gosu::Color::BLACK, 100)
    @player.draw
    @player_bullets.map &:draw
    @enemies.map &:draw
    @enemy_bullets.map &:draw
    @effects.map &:draw
    @items.map &:draw
    @font.draw("Bullets: #{@player_bullets.count + @enemy_bullets.count}", *@score_area.relative(10, 10), 101, 1.0, 1.0, 0xff_ffffff)
    @font.draw("FPS: #{Gosu.fps}", *@score_area.relative(10, 30), 101, 1.0, 1.0, 0xff_ffffff)
    @boss&.draw
  end

  def process_collisions
    @player_bullets.each do |bullet|
      @enemies.each do |enemy|
        if enemy.alive? && bullet.alive? && collision?(enemy.collision_body, bullet.collision_body)
          enemy.hitted_by bullet
          bullet.hitted enemy
        end
      end
    end

    @items.each do |item|
      if item.alive? && collision?(@player.collision_body, item.collision_body)
        item.picked_by @player
      end
    end

    @enemy_bullets.each do |bullet|
      #if graze? @player, bullet, 0.5
      #  @player.graze bullet
      #end

      if !@player.ghost? && bullet.alive? && collision?(@player.collision_body, bullet.collision_body)
        @player.hitted_by bullet
        bullet.hitted @player
      end
    end
  end

  def add_player_bullet bullet, from = :enemy
    if from == :player
      @player_bullets << bullet
    else
      @enemy_bullets << bullet
    end
    bullet
  end

  def add_bullet type, params={}, &block
    class_name = type.to_s.split('_').map(&:capitalize).join
    bullet = Module.const_get(class_name).new(params, &block)
    @enemy_bullets << bullet
    bullet
  end

  def add_enemy type, params={}, &block
    class_name = type.to_s.split('_').map(&:capitalize).join
    enemy = Module.const_get(class_name).new(params, &block)
    @enemies << enemy
    enemy
  end

  def add_presenter &block
    @presenters << Presenter.new(&block)
  end
end