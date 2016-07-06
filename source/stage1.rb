
class Stage1 < Stage
  include DanmukuHelpers
  def drama
    stage = self

    #six_enemy_1_group Vector[battle_area.x1 + 70, -10], :left, false
=begin
    stage.vector_iter :-, [battle_area.x1 + 70, -10], 6, [-20, 0] do |cursor|
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
    end
=end
    #wait 1
    #six_enemy_1_group Vector[battle_area.x2 - 70, -10], :right, false
    #wait 1
    #six_enemy_1_group Vector[battle_area.x1 + 70, -10], :left, false
    #wait 3
    #six_enemy_1_group Vector[battle_area.x2 - 70, -10], :right, false
    #wait 3
begin
    battle_scene.add_presenter do
      stage.vector_iter :+, [100,-20], 5, [100,0] do |cursor|
        battle_scene.add_enemy :enemy_1 do
          set position: cursor,
              velocity: Vector[0, 3]

          wait 1
          set velocity: Vector[0, 0]
          wait 0.5

          stage.sector_iter 52.5, 90, 6 do |a|
            battle_scene.add_bullet :enemy_bullet_1,
                                    position: @position,
                                    velocity: Vector[Math.cos(Math.rad(a)), Math.sin(Math.rad(a))].normalize * 3,
                                    &behaviors.to_be_decelerate(0, -0.01, 1)
          end

          wait 0.5
          set velocity: Vector[0, 1.8],
              acceleration: Vector[-0.03, -0.05]
          wait 1
          set acceleration: Vector[0, 0]
        end
        wait 0.3
      end
    end

    stage.vector_iter :+, [50, -10], 5, [100, 0] do |cursor|
      battle_scene.add_enemy :enemy_1 do
        set position: cursor,
            velocity: Vector[0, 1.8]

        wait 1
        set velocity: Vector[0, 0]
        wait 0.5

        stage.sector_iter 52.5, 90, 6 do |a|
          battle_scene.add_bullet :enemy_bullet_1,
                                  position: @position,
                                  velocity: Vector[Math.cos(Math.rad(a)), Math.sin(Math.rad(a))].normalize * 3,
                                  &behaviors.to_be_decelerate(0, -0.01, 1)
        end

        wait 0.5
        set velocity: Vector[0, 1.8],
            acceleration: Vector[-0.03, -0.05]
        wait 1
        set acceleration: Vector[0, 0]
      end
      wait 0.3
    end
end
    stage.perform_rumia
    wait_for { battle_scene.boss }
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

  def iter type, from, times, increment
    times.times do
      yield from
      from = from.send(type, increment)
    end
  end

  def vector_iter type, from, times, increment, &block
    iter type, Vector[*from], times, Vector[*increment], &block
  end

  def sector_iter start, total, step
    per_step = total / step
    step.times do |i|
      a = start + i*per_step
      yield a
    end
  end

  def perform_rumia
    stage = self
    battle_scene.add_enemy :rumia do |boss|
      set position: Vector[180, -30],
          velocity: Vector[3, 3]

      wait 0.5

      set velocity: Vector[0, 0]

      while @hp > 0
        3.times do
          stage.sector_iter 0, 360, 30 do |a|
            battle_scene.add_bullet :enemy_bullet_2,
                                    position: boss.position,
                                    velocity: angle_to_vector(a) * 8,
                                    color: :yellow,
                                    &behaviors.to_be_decelerate(1, -0.2, 0.5)
          end
          wait 0.2
        end
        3.times do
          stage.sector_iter 30, 360, 30 do |a|
            battle_scene.add_bullet :enemy_bullet_2,
                                    position: boss.position,
                                    velocity: angle_to_vector(a) * 8,
                                    color: :blue,
                                    &behaviors.to_be_decelerate(1, -0.2, 0.5)
          end
          wait 0.2
        end
        break if @hp <= 0

        set velocity: Vector[-3, 1]
        wait 0.7
        set velocity: Vector[0, 0]
        3.times do
          stage.sector_iter 0, 360, 30 do |a|
            battle_scene.add_bullet :enemy_bullet_2,
                                    position: boss.position,
                                    velocity: angle_to_vector(a) * 8,
                                    &behaviors.to_be_decelerate(1, -0.2, 0.5)
          end
          wait 0.2
        end
        3.times do
          stage.sector_iter 30, 360, 30 do |a|
            battle_scene.add_bullet :enemy_bullet_2,
                                    position: boss.position,
                                    velocity: angle_to_vector(a) * 8,
                                    color: :blue,
                                    &behaviors.to_be_decelerate(1, -0.2, 0.5)
          end
          wait 0.2
        end
        break if @hp <= 0

        set velocity: Vector[3, -1]
        wait 0.7
        set velocity: Vector[0, 0]

        3.times do
          stage.sector_iter 0, 360, 30 do |a|
            battle_scene.add_bullet :enemy_bullet_2,
                                    position: boss.position,
                                    velocity: angle_to_vector(a) * 8,
                                    &behaviors.to_be_decelerate(1, -0.2, 0.5)
          end
          wait 0.2
        end
        3.times do
          stage.sector_iter 30, 360, 30 do |a|
            battle_scene.add_bullet :enemy_bullet_2,
                                    position: boss.position,
                                    velocity: angle_to_vector(a) * 8,
                                    color: :blue,
                                    &behaviors.to_be_decelerate(1, -0.2, 0.5)
          end
          wait 0.2
        end
        break if @hp <= 0

        set velocity: Vector[3, 1]
        wait 0.7
        set velocity: Vector[0, 0]

        3.times do
          stage.sector_iter 0, 360, 30 do |a|
            battle_scene.add_bullet :enemy_bullet_2,
                                    position: boss.position,
                                    velocity: angle_to_vector(a) * 8,
                                    &behaviors.to_be_decelerate(1, -0.2, 0.5)
          end
          wait 0.2
        end
        3.times do
          stage.sector_iter 30, 360, 30 do |a|
            battle_scene.add_bullet :enemy_bullet_2,
                                    position: boss.position,
                                    velocity: angle_to_vector(a) * 8,
                                    color: :blue,
                                    &behaviors.to_be_decelerate(1, -0.2, 0.5)
          end
          wait 0.2
        end
        break if @hp <= 0

        set velocity: Vector[-3, -1]
        wait 0.7
        set velocity: Vector[0, 0]

      end

      set velocity: Vector[0, -3]
      wait_for { @position.y < -30 }
      set velocity: Vector[0, 0]
    end
  end

end