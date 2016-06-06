class BulletFactory
  include Helpers

  def initialize &block
    @cool_down = 0
    @position_proc = block
  end

  def update
    @cool_down -= 1 if @cool_down > 0
  end

  def process_fire
    if @cool_down.zero?
      create_bullet.each{|x| battle_scene.add_bullet x}
      @cool_down = @interval
    end
  end

end