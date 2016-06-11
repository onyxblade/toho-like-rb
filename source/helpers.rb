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

class Rect < Array
  def self.[](x1, y1 = nil, x2 = nil, y2 = nil)
    if x2.nil?
      super *[x1, y1].map{|x| x.is_a?(Vector) ? x : Vector[*x] }
    else
      super Vector[x1, y1], Vector[x2, y2]
    end
  end

  def x1
    self[0][0]
  end

  def y1
    self[0][1]
  end

  def x2
    self[1][0]
  end

  def y2
    self[1][1]
  end

  def contain_point? x1, x2

  end

  def relative x, y
    Vector[x1 + x, y1 + y]
  end
end