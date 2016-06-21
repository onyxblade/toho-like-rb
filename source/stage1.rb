
class Stage1 < Stage
  def drama
    #finished = six_enemy_1_group Vector[battle_area.x1 + 50, -10], :left, false
    #wait_for &finished
    six_enemy_1_group Vector[battle_area.x2 - 50, -10], :right, false
  end

  def six_enemy_1_group begin_position, direction, will_fire = false
    cursor = begin_position
    enemies = []
    6.times do
      enemy = add_enemy :enemy_1 do
        set position: cursor,
            velocity: Vector[0, 1.8],
            speed: 1.5

        wait 2.5

        v = case direction
            when :left
              Vector[-0.5, 1]
            when :right
              Vector[0.5, 1]
            end

        t = case direction
            when :left
              Vector[@position.x - 200, @position.y + 100]
            when :right
              Vector[@position.x + 200, @position.y + 100]
            end

        set velocity: v,
            tracing: true,
            target_position: t,
            turning_speed: 0

        p @turning_speed
        if will_fire

        end
      end

      enemies << enemy

      cursor =  case direction
                when :left
                  Vector[cursor.x + 20, cursor.y]
                when :right
                  Vector[cursor.x - 20, cursor.y]
                end
      wait 0.3
    end
    proc {enemies.all?{|x| !x.alive?}}
  end
end