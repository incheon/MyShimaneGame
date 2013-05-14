#coding: SJIS

class EnemyMayor < Sprite
  
  CHUGOKU = 1
  WESTJP = 2
  ALLJP = 3
  
  #デフォルトコンストラクタ
  def initialize(x,y,modeint = 1)
    img = nil
    case modeint
    when CHUGOKU then img = "tiji_tottori.png"
    when WESTJP then img = "tiji_tottori.png"
    when ALLJP then img = "tiji_tottori.png"
    end
    super(x,y,Image.load(File.expand_path("../../image/" + img, __FILE__)))
    @dx = 0
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
    #    speed = 5
    #    @dx = Input.x*speed
    #    diff = 30
    #    if self.x < 0 + diff + Window.width/2 then @dx = speed
    #    elsif self.x > (self.image.width - diff) then @dx -= speed
    #    else @dx += Input.x * speed
    #    end
    #    self.x += @dx
  end
end
