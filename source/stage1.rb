
class Stage1 < Stage
  def drama
    stage = self

    #six_enemy_1_group Vector[battle_area.x1 + 70, -10], :left, false
    #wait 3
    #six_enemy_1_group Vector[battle_area.x2 - 70, -10], :right, false
    #wait 3
    #six_enemy_1_group Vector[battle_area.x1 + 70, -10], :left, false
    #wait 3
    #six_enemy_1_group Vector[battle_area.x2 - 70, -10], :right, false
    #wait 3
    battle_scene.add_worker do
      stage.cursor_sequence [100, -20], [100, 0], 5 do |cursor|
        battle_scene.add_enemy :enemy_1 do
          set position: cursor,
              velocity: Vector[0, 1.8]

          wait 1
          set velocity: Vector[0, 0]
          wait 0.5

          stage.create_sector_bullets @position

          wait 0.5
          set velocity: Vector[0, 1.8],
              acceleration: Vector[-0.03, -0.05]
          wait 1
          set acceleration: Vector[0, 0]
        end
        wait 0.3
      end
    end

    stage.cursor_sequence [50, -10], [100, 0], 5 do |cursor|
      battle_scene.add_enemy :enemy_1 do
        set position: cursor,
            velocity: Vector[0, 1.8]

        wait 1
        set velocity: Vector[0, 0]
        wait 0.5

        stage.create_sector_bullets @position

        wait 0.5
        set velocity: Vector[0, 1.8],
            acceleration: Vector[-0.03, -0.05]
        wait 1
        set acceleration: Vector[0, 0]
      end
      wait 0.3
    end
  end

  def six_enemy_1_group begin_position, direction, will_fire = false
    cursor = begin_position
    6.times do
      battle_scene.add_enemy :enemy_1 do
        set position: cursor,
            velocity: Vector[0, 1.8],
            speed: 1.5

        wait 2.5

        set acceleration: case direction
                          when :left
                            Vector[-0.03, 0]
                          when :right
                            Vector[0.03, 0]
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

  def create_sector_bullets position
    6.times.each do |i|
      a = 52.5 + i*15
      battle_scene.add_bullet :enemy_bullet_1 do
        set position: position,
            velocity: Vector[Math.cos(Math.rad(a)), Math.sin(Math.rad(a))].normalize * 3

        within 1 do
          boost_velocity -0.01
        end
      end
    end
  end

  def cursor_sequence cursor, increment, times
    cursor = Vector[*cursor]
    increment = Vector[*increment]

    times.times do
      yield cursor
      cursor += increment
    end
  end

  def add_worker &block
    battle_scene.workers << Enumerator.new do |enum|
      enum
    end
  end

end