#メイン文

#dxrubyの呼び出し
require 'dxruby'

#ウィンドウサイズの設定
Window.width = 800
Window.height = 600

#作成したクラス群の呼び出し
require 'scene'
require 'title'
require 'level'
require 'game'
require 'bullet'
require 'item'
require 'crab'
require 'camel'
require 'orochi'
require 'pear'
require 'shijimi'
require 'money'
require 'citizen'
require 'enemy_mayor'
require 'mayor'
require 'enemy'

#シーンのインスタンス化と命名
Scene.add_scene(:title, Title.new)
Scene.add_scene(:level, Level.new)
Scene.add_scene(:chugoku, Game.new(Game::CHUGOKU))
Scene.add_scene(:westjp, Game.new(Game::WESTJP))
Scene.add_scene(:alljp, Game.new(Game::ALLJP))

#最初のシーンをどれにするか
Scene.set_scene(:title)

#Sceneのインスタンスを切り替えながら表示
Window.loop do
  break if (Input.keyPush?(K_ESCAPE) || Scene.get_finish)
  Scene.play#シーンのplayメソッド呼び出し
end
