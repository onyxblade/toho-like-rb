class Boss < Enemy

  def initialize
    super
    @life_bar = 1
  end

  def collision_body
    [@position, 20]
  end

  def hitted_by bullet
    @hp -= bullet.demage
  end

  def update
    super
    @life_bar = (@hp.to_f / @total_hp)
  end

  def draw
    if @life_bar > 0
      life_bar_length = 450
      Gosu.draw_rect(50, 20, life_bar_length*@life_bar, 3, 0xccffffff, 100)
    end
  end
end