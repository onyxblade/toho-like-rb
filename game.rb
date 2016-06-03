require 'gosu'
require 'active_support'
require 'active_support/core_ext'
require 'matrix'

Dir.glob('source/*.rb').each{ |x| require_relative x }

class GameWindow < Gosu::Window
  def initialize
    super 800, 600
    self.caption = 'Touhou like game'

    @player = Player.new
  end

  def update
    if Gosu::button_down? Gosu::KbLeft
      @player.move [-1, 0]
    end
    if Gosu::button_down? Gosu::KbRight
      @player.move [+1, 0]
    end
    if Gosu::button_down? Gosu::KbUp
      @player.move [0, -1]
    end
    if Gosu::button_down? Gosu::KbDown
      @player.move [0, +1]
    end
  end

  def draw
    @player.draw
  end
end

window = GameWindow.new
window.show