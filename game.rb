require 'gosu'
require 'matrix'

require './source/helpers'
Dir.glob('source/*.rb').each{ |x| require_relative x }

class GameWindow < Gosu::Window
  include Helpers

  def initialize
    super 800, 600
    self.caption = 'Touhou like game'

    BattleScene.instance = BattleScene.new
    @scene = BattleScene.instance
  end

  def update
    @scene.update
  end

  def draw
    @scene.draw
  end
end

window = GameWindow.new
window.show