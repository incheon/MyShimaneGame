# To change this template, choose Tools | Templates
# and open the template in the editor.

#ホバーしてる時に何かしらのイベントを行うようなボタン
class HoverButton < Sprite
  
  attr_reader :img
  
  #  デフォルトコンストラクタ
  def initialize(img)#背景画像を初期値に設定
    self.img = img
  end
  
  #  アップデート処理
  attr_reader :cursorbit 
  def update
    
    x = Input.mousePosX  # マウスカーソルのx座標
    y = Input.mousePosY  # マウスカーソルのy座標
    bitImg = Image.load("../image/")#擬似クリックのための透明画像
    Window.load(x,y,bitImg)
    
    @hovering =  false #ホバリング判定
    if self.x < bitimg.x and (bitimg.x<self.x + self.widt) and self.y <bitimg.y  and bitimg.y<(self.y + self.height) then
      @hovering =  true
    end
    
  end
  
  def hovering?
    return @hovering
  end

end
