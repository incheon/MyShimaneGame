#coding: SJIS
class Enemy < Sprite
  
  #デフォルトコンストラクタ
  def initialize(x,y)
    #puts "できた"
    super(x,y,Image.load(File.expand_path("../image/tiji.png", __FILE__)))
    #@dx = 0
    @speed = 2
  end

      

  #アップデート処理
  def update
    self.x += @speed
    if(self.x > 700)
    	@speed = -@speed
    end

    if(self.x < 430)
    	@speed = -@speed
    end

  end
  
end
