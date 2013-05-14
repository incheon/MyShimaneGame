#メイン文

#dxrubyの呼び出し
require 'dxruby'

#ウィンドウサイズの設定
Window.width = 800
Window.height = 600

#作成したクラス群の呼び出し
classes = ['scene', 'level', 'game', 'bullet', 
  'item', 'crab', 'camel', 'orochi', 'pear', 'shijimi', 
  'money', 'citizen', 'enemy_mayor', 'mayor', 'enemy', 'title']
classes.each { |item|  require item }

#シーンのインスタンス化と命名
scenes = {
  ":title" => Title.new,  
  ":level" => Level.new,
  ":chugoku" => Game.new(Game::CHUGOKU),  
  ":westjp" => Game.new(Game::WESTJP),  
  ":alljp" => Game.new(Game::ALLJP)
}
scenes.each { |key,value| Scene.add_scene(key, value)}

#最初のシーンをどれにするか
Scene.set_scene(:title)
pp Scene

#Sceneのインスタンスを切り替えながら表示
Window.loop do
  #ECSキーで終了
  break if (Input.keyPush?(K_ESCAPE) || Scene.get_finish)
  #シーンのplayメソッド呼び出し
  Scene.play 
end
