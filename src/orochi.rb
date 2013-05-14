# To change this template, choose Tools | Templates
# and open the template in the editor.

class Orochi < Item
  
  #デフォルトコンストラクタ
  def initialize(x,y)
    img = Image.load(File.expand_path("../../image/fall_item/yamata.png", __FILE__))
    img.setColorKey([255,255,255])
    super(x,y,img)
    @point = 100
#		@x_speed = 1.0
#		@x_direction = 1.0
  end
  
  #バニッシュ
  def vanished?
    @vanished
  end
  
end
