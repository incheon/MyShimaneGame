# To change this template, choose Tools | Templates
# and open the template in the editor.

class Bullet < Sprite
  
  #アクセス範囲
  attr_accessor :startY, :startX
  attr_accessor :drawX, :drawY, :drawR
  attr_accessor :limitAbove, :limitBelow, :limitLeft, :limitRight
  attr_accessor :mouse_x, :mouse_y
  
  #デフォルトコンストラクタ
  def initialize(x = 0.0, y = 0.0, up = 0.0, down = 100.0,
      left =  0.0, right = 100.0, isplayer = false)
    
    @startX, @startY= x, y #表示開始地点
    @limitAbove, @limitBelow, @limitLeft, @limitRight = up, down, left, right #玉の有効範囲の境界線を保存
    
    #マウス座標の保存
    @mouse_x, @mouse_y = Input.mousePosX, Input.mousePosY if isplayer
    @mouse_x, @mouse_y = rand(right - left) + left, rand(down - up) + up if not isplayer
    
    #弾のサイズ（縦、横、直径）
    size = 20
    @drawX, @drawY, @drawR = size/2, size/2, size/2
    
    #弾を描画
    super(@startX,@startY, Image.new(@startX,@startY).circleFill(@drawX, @drawY, @drawR, [0,0,0]))
  end
  
  #アップデート
  def update
    
    #玉のスピード
    speed_x = 20
    speed_y = 20
    
    #玉の位置更新
    hyp = Math.hypot((self.mouse_x - self.img_base_x), (self.mouse_y - self.img_base_y))
    self.x += speed_x * ((@mouse_x-@startX)/hyp)
    self.y += speed_y * ((@mouse_y-@startY)/hyp)
    #本当は画面外に出たら消したいが、これをやると初めから消えてしまう
    #    @vanished = true if has_out

  end
  
  # アイテムに当たった場合
  def shot(obj)
    (@vanished = true if not obj.falling)if obj.is_a?(Item)
  end
    
  
  #玉が画面外（+-100px）に出たかどうかの判定
  def has_out
    
    flag = false
    flag = true if ((self.x<@limitLeft) || (@limitRight<self.x+self.image.width))
    flag = true if ((self.y<@limitAbove)||(@limitBelow<self.y+self.image.height))
    
    return flag
  end
  
  #玉が画面外（+-100px）に出たかどうかの値
  def vanished?
    return @vanished
  end
  
end
