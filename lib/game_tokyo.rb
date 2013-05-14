?ｿ#coding: SJIS

class Game_tokyo
  def initialize
    @bg_img = Image.load("image/game_bg.png")
	@img_shimane = Image.load("image/shimane.png")
	@img_tokyo = Image.load("image/tokyo.png")
    @tiji   = Image.load("image/tiji.png")

  end

  def play
    Scene.set_scene(:game) if Input.keyPush?(K_SPACE)
    Window.draw(0, 0, @bg_img)
	Window.draw(25,25, @img_shimane)
    Window.draw(450, 25, @img_tokyo)
	Window.draw( 31,392,@tiji)
	Window.draw(255,392,@tiji)
	Window.draw(456,392,@tiji)
	Window.draw(680,392,@tiji)
  end
end