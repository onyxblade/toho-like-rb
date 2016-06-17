class ReimuAssistBulletFactory < BulletFactory
  class << self
    attr_accessor :image
  end

  def initialize level, &block
    super &block
    self.class.image ||= Gosu::Image.new 'image/reimu_option.png'
    @rotation_a = 0
    @rotation_b = 90
    @interval = 1
    @sita = 180
    @interval = 30
  end

  def update
    super
    @rotation_a += 5
    @rotation_b -= 5
    if Gosu::button_down? Gosu::KbLeftShift
      @sita += 7
    elsif
      @sita -= 25
    end
    @sita = @sita > 255 ? 255 : @sita
    @sita = @sita < 180 ? 180 : @sita
  end

  def draw
    position = @position_proc.call
    position_a = Vector[position[0]+25, position[1]] # same as canvas_position (for draw_rot)
    position_b = Vector[position[0]-25, position[1]]
    position_a = calc_assist_position position, :left
    position_b = calc_assist_position position, :right
    self.class.image.draw_rot(*position_a, 0, @rotation_a, 0.5, 0.5, 1, 1, 0xaaffffff)
    self.class.image.draw_rot(*position_b, 0, @rotation_b, 0.5, 0.5, 1, 1, 0xaaffffff)
  end

  def calc_assist_position position, type
    r = 30
    case type
    when :left
      mat = Matrix[[1, 0, r * Math.cos(Math.rad(@sita))], [0, 1, r * Math.sin(Math.rad(@sita))], [0, 0, 0]]
      (mat * Vector[*position, 1]).xy
    when :right
      mat = Matrix[[1, 0, r * Math.cos(Math.rad(-@sita+180))], [0, 1, r * Math.sin(Math.rad(-@sita+180))], [0, 0, 0]]
      (mat * Vector[*position, 1]).xy
    end
  end

  def create_bullet
    position = @position_proc.call
    [
      ReimuBullet2.new(Vector[position[0]-3, position[1]]),
      ReimuBullet2.new(Vector[position[0]+3, position[1]])
    ]
  end
end