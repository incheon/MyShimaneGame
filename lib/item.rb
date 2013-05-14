# coding: Shift_JIS

#アイテムを表すクラス
class Item < Sprite
  
  #クラス変数群
  @@point = 10#デフォルトの得点
  @@default_y_speed = 1#デフォルトの落下速度
  @@default_x_speed = 1#デフォルトの横速度
  @@balloon = Image.load(File.expand_path("../../image/ballon.png", __FILE__))#バックグラウンド画像
  @@friendpoint = 0
  @@enemydpoint = 0
  
  #ここでの特性は基本全て読み取り専用
  #継承先で可変して出力する
  attr_reader :point
  attr_reader :default_y_speed
  attr_reader :default_x_speed
  attr_reader :ballon
  attr_accessor :friendpoint
  attr_accessor :enemypoint
  
	attr_reader :falling
  
  #インスタンス変数群
	attr_accessor :point#アイテムの得点
	attr_accessor :x_speed#縦方向速度
	attr_accessor :x_direction#横方向速度
  
  #クラス変数へのアクセサ
  def Item.get_friendpoint
    @@friendpoint
  end
  def Item.set_friendpoint(x)
    @@friendpoint = x
  end
  def Item.add_friendpoint(x)
    @@friendpoint += x
  end
  
  def Item.get_enemydpoint
    @@friendpoint
  end
  def Item.set_enemydpoint(x)
    @@friendpoint = x
  end
  def Item.add_enemydpoint(x)
    @@friendpoint += x
  end
  
  #デフォルトコンストラクタ
	def initialize(x, y, img = Image.load(File.expand_path("../../image/fall_item/nashi.png", __FILE__))) #デフォルトは『なし』の画像
    img2 = Image.load(File.expand_path("../../image/fall_item/frame.png", __FILE__))#バックグラウンド画像(アイテムの背後に丸などを)
		img2.setColorKey([0,0,0])
    img2.draw(0,0,img.setColorKey([0,255,0]))#アイテムの画像を読んで透過処理＋背後と合成
    @point = 0
		super(x,y,img2)#合成画像を使ってスーパーコンストラクタ呼び出し
    @x_speed = 1#@@default_y_speed 
    @x_direction = 1#@@default_x_speed
    
    @falling = false
    @ay =0
    self.scale_x = 0.5
    self.scale_y = 0.5
    
    #    Item.resetpoint
	end

	def update
    # 蛇行（通常の）落下中
    if not @falling then 
      self.y += 0.2 #全体を下へ下げる
    
      if self.x <= 385
        if (self.x >= 380-self.image.width)||(self.x <= 15)
          if (self.y <= Window.height - 400)||(self.x >= 380-self.image.width)
            @x_speed = 0
            @x_direction *= -1
          end
          self.x -= 1 if self.x >= 380-self.image.width
          self.x += 1 if self.x <= 15 if self.y <= Window.height - 400
        end
      else
        if (self.x >= Window.width - self.image.width)||(self.x <= Window.width - 360)
          if (self.y <= Window.height - 400)||(self.x <= Window.width - 360)
            @x_speed = 0
            @x_direction *= -1
          end
          self.x -= 1 if self.x >= Window.width - self.image.width
          self.x += 1 if self.x <= Window.width - 360
        end
      end

      @x_speed += 0.04
      self.x += (@x_speed*@x_direction)
      @vanished = true if self.y >= Window.height - 350
    
      #玉に当たってからの落下中
    else
      @ay += 0.3 #落下加速度
      self.y += @ay #位置計算
    end
	end

	def vanished?
		return @vanished
	end
  
  def hit(bullet)
    @falling = true
  end
  
  def shot(citizen)
    @vanished = true
  end
  
  def Item.resetpoint
    Item.set_friendpoint(0)
    Item.set_enemydpoint(0)
  end
end