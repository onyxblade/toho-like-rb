
class Stage1 < Stage
  def drama
    six_enemy_1_group Vector[50, -10], :left, false
    wait 3
    six_enemy_1_group Vector[450, -10], :right, false
  end

  def six_enemy_1_group begin_position, direction, will_fire = false
    cursor = begin_position
    6.times.map do |i|
      add_enemy :enemy_1 do
        set position: cursor,
            velocity: Vector[0, 1.8]

        wait 2.5

        v = case direction
            when :left
              Vector[-0.5, 1]
            when :right
              Vector[0.5, 1]
            end

        set velocity: v

        if will_fire

        end
      end

      cursor =  case direction
                when :left
                  Vector[cursor.x + 20, cursor.y]
                when :right
                  Vector[cursor.x - 20, cursor.y]
                end
      wait 0.3
    end
  end
end