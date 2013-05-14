# coding: Shift_JIS

# Citizenは一般市民を表すクラス
class Citizen < Sprite
  
  #インスタンス変数群
  @travering = false # 移動中の判定
  @isItemTrue = false # 要求アイテムの判定（正しくなかったら隣の県にいってしまう？？
  @px = 100 # 初期位置
  @appearRight = false # falseで左（自分側）に、trueで右（敵側）に現れる
  
  #アクセス
  attr_accessor :requirement
  attr_accessor :isItemTrue
  
  #デフォルトコンストラクタ
	def initialize(x, which) 
		self.image = Image.load(File.expand_path("../../image/citizen.png", __FILE__))#本体の画像
		@travering = false
		@isItemTrue = false
		@px = x
		@py = 456
		@appearRight = which # left
		self.x = @px
		self.y = @py
    @requirement = getitemrandom #要求アイテムの設定
    
	end
  
	def update
    self.draw
    @requirement.update
		Sprite.draw(@requirement)
		move if @isItemTrue
		@vanished = true if self.y >= Window.height - 325
	end

	def move
    speed = 5 #スピード
		if @appearRight then # 左のウィンドウへ移動する
      self.x += -speed
		else
      self.x += speed # 右のウィンドウに移動する
		end
	end

  #衝突判定
	def hit(obj)
    if obj.is_a?(Item) then #アイテムとの衝突の場合
      if requirement.is_a?(obj.class) then #要求と同じアイテムの場合
        @isItemTrue = true
        Item.add_friendpoint(obj.point)
      end
    end
	end

	def vanished?
		return @vanished
	end
  
  #要求アイテムをランダムに発生させる
  def getitemrandom
    #確率に応じたアイテム生成
    posarr = [40,40,20]
    flag = rand(posarr.inject{|sum, n| sum + n })
    sum = 0.0
    count = 1
    
    posarr.each do |item|
      sum += item
      break if flag < sum
      count += 1
    end
    tmp = nil
    case count
    when 1 then tmp = Shijimi.new(self.x,self.y+100)
    when 2 then tmp = Money.new(self.x,self.y+100)
    else tmp = Orochi.new(self.x,self.y+100)
    end
    return tmp
  end
end