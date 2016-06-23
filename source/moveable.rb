module Moveable
  def boost_velocity diff
    v = @velocity
    set velocity: (v.normalize * (v.r + diff))
  end
end