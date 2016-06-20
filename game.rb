require 'gosu'
require 'matrix'

require './source/helpers'

def Object.const_missing name
  file_name = name.to_s.scan(/[A-Z][a-z]*/).join('_').downcase
  require_relative "source/#{file_name}"
  const_get(name)
end

Dir.glob('source/*.rb').each{ |x| require_relative x }

include Helpers

class GameWindow < Gosu::Window
  attr_accessor :scene

  class << self
    attr_accessor :instance
  end

  include Helpers

  def initialize
    super 800, 600, false
    self.caption = 'Touhou like game'

    BattleScene.instance = BattleScene.new
    @scene = BattleScene.instance
    #@scene = CharacterSelectScene.new
  end

  def update
    @scene.update
  end

  def draw
    @scene.draw
  end
end

window = GameWindow.new
GameWindow.instance = window
window.show