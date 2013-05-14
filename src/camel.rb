# coding: SJIS

class Camel < Item
  #デフォルトコンストラクタ
  def initialize(x,y)
    super(x,y,Image.load(File.expand_path("../../image/fall_item/rakuda.png", __FILE__)))
    @point = 100
    #		@x_speed = 1.0
    #		@x_direction = 1.0
  end
  
  #バニッシュ
  def vanished?
    @vanished
  end
end
