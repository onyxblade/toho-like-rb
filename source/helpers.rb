module Helpers
  def battle_scene
    BattleScene.instance
  end

  def battle_area
    battle_scene.battle_area
  end
end