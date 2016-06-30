module DanmukuHelpers
  def to_be_decelerate position, velocity, wait_second, deceleration, within_second
    proc do
      set position: position,
          velocity: velocity
      wait wait_second

      within within_second do
        boost_velocity deceleration
      end
    end
  end
end