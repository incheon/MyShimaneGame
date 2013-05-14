# To change this template, choose Tools | Templates
# and open the template in the editor.

class Bullet < Sprite
  
  attr_accessor :img_base_x
  attr_accessor :img_base_y
  attr_accessor :base_x
  attr_accessor :base_y
  attr_accessor :base_r
  
  attr_accessor :bd_up
  attr_accessor :bd_down
  attr_accessor :bd_left
  attr_accessor :bd_right
  attr_accessor :mouse_x
  attr_accessor :mouse_y
  
  #デフォルトコンストラクタ
  def initialize(x = 0.0, y = 0.0, up = 0.0, down = 100.0, left =  0.0, right = 100.0, ai = false)
    
    #表示開始地点
    @img_base_x, @img_base_y= x, y
    
    #サイズ（縦、横、直径）
    size = 20 #大元のサイズ
    @base_x, @base_y, @base_r = size/2, size/2, size/2
    super(@img_base_x,@img_base_y, Image.new(@img_base_x,@img_base_y).circleFill(@base_x, @base_y, @base_r, [0,0,0]))
    
    #玉の有効範囲の境界線を保存
    @bd_up, @bd_down, @bd_left,@bd_right = up, down, left, right
    
    #マウス座標の保存
    if not ai then
      p "player"
      @mouse_x, @mouse_y = Input.mousePosX, Input.mousePosY
    else
      p "ai"
      @mouse_x, @mouse_y = rand(right - left) + left, rand(down - up) + up
    end
  end
  
  #アップデート
  def update
    
    #玉のスピード
    speed_x = 20
    speed_y = 20
    
    #玉の位置更新
    hyp = Math.hypot((self.mouse_x - self.img_base_x), (self.mouse_y - self.img_base_y))
    self.x += speed_x * ((@mouse_x-@img_base_x)/hyp)
    self.y += speed_y * ((@mouse_y-@img_base_y)/hyp)
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
    flag = true if ((self.x<@bd_left) || (@bd_right<self.x+self.image.width))
    flag = true if ((self.y<@bd_up)||(@bd_down<self.y+self.image.height))
    
    return flag
  end
  
  #玉が画面外（+-100px）に出たかどうかの値
  def vanished?
    return @vanished
  end
  
end
