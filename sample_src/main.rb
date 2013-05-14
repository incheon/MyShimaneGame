require 'dxruby'

require 'lib/scene'
require 'lib/title'
require 'lib/game'
require 'lib/ending'
require 'lib/block'
require 'lib/map'

game   = Game.new
title  = Title.new
ending = Ending.new

Scene.add_scene(:title,  title)
Scene.add_scene(:game,   game)
Scene.add_scene(:ending, ending)

Scene.set_scene(:title)


Window.loop do
  break if Input.keyPush?(K_ESCAPE) || ending.closed
  Scene.play
end
