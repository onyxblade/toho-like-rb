module Behavior
  def initialize_behavior &block
    @behavior = Enumerator.new do |yielder|
      @yielder = yielder
      instance_eval(&block)
      loop do
        yielder.yield nil
      end
    end
    @behavior.next
  end

  def set hash = {}
    hash.each{|key, value| instance_variable_set("@#{key}", value)}
  end

  def wait second
    frames = (second * 60).to_i
    frames.times{ @yielder.yield nil }
  end

  def wait_for &block
    @yielder.yield nil until instance_eval(&block)
  end

  def add_bullet *args, &block
    battle_scene.add_bullet *args, &block
  end

  def add_enemy *args, &block
    battle_scene.add_enemy *args, &block
  end

  def within second
    frames = (second * 60).to_i
    frames.times{ @yielder.yield yield }
  end

  def boost_velocity diff
    v = @velocity
    set velocity: (v.normalize * (v.r + diff))
  end

end