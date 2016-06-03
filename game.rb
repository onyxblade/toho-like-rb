require 'gosu'

class GameWindow < Gosu::Window
  def initialize
    super 800, 600
    self.caption = 'Touhou like game'
  end

  def update

  end

  def draw

  end
end

window = GameWindow.new
window.show