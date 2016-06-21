class CharacterSelectScene
  def initialize
    @selected = 'reimu'
    @reimu_image = Gosu::Image.new('image/reimu_stand.png')
    @marisa_image = Gosu::Image.new('image/marisa_stand.png')
    @font = Gosu::Font.new(50)
  end

  def update
    if Gosu::button_down? Gosu::KbRight
      @selected = 'marisa'
    elsif Gosu::button_down? Gosu::KbLeft
      @selected = 'reimu'
    elsif Gosu::button_down? Gosu::KbZ
      battle_scene = BattleScene.new(@selected)
      BattleScene.instance = battle_scene
      GameWindow.instance.scene = battle_scene
    end
  end

  def draw
    if @selected == 'reimu'
      @reimu_image.draw(50, 50, 1, 1, 1, 0xff_ffffff)
      @marisa_image.draw(340, 50, 0, 1, 1, 0x33_ffffff)
    else
      @reimu_image.draw(50, 50, 0, 1, 1, 0x33_ffffff)
      @marisa_image.draw(340, 50, 1, 1, 1, 0xff_ffffff)
    end
    @font.draw_rel("Character Select", 395, 50, 0, 0.5, 0.5)
  end
end