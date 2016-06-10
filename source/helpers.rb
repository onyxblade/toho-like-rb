module Helpers
  def battle_scene
    BattleScene.instance
  end

  def battle_area
    battle_scene.battle_area
  end

  def draw_indicator x, y
    Gosu.draw_rect(x, y, 5, 5, Gosu::Color::BLUE, 99)
  end
end

module Math
  def self.rad angle
    angle / 180.0 * Math::PI
  end

  def self.deg radian
    radian * 180.0 / Math::PI
  end
end

class Vector

  ['x', 'y', 'z', 'w'].each_with_index do |x, i|
    define_method x do
      self[i]
    end
  end

  (2..4).each do |x|
    ['x', 'y', 'z', 'w'].permutation(x).to_a.each do |arr|
      define_method arr.join do
        Vector[*arr.map{|x| send(x)}]
      end
    end
  end

end