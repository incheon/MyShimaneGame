# To change this template, choose Tools | Templates
# and open the template in the editor.

class Crab < Item
  
  #デフォルトコンストラクタ
  def initialize(x,y)
    img = Image.load(File.expand_path("../../image/fall_item/kani.png", __FILE__))
    img.setColorKey([255,255,255])
    super(x,y,img)
    @point = 10
#    @x_speed = 1
#    @x_direction = 1
  end
  
  #バニッシュ
  def vanished?
    @vanished
  end
  
end
