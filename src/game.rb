#coding: SJIS

class Game

  CHUGOKU = 1
  WESTJP = 2
  ALLJP = 3
  
  #デフォルトコンストラクタ
  def initialize(modeint)
    
    @nextscene = :tilte
    
    #各モードに合わせて背景を変更
    imgname = nil
    case modeint
    when CHUGOKU then imgname = 'bg_chugoku.png'
    when WESTJP then imgname = 'bg_westjp.png'
    when ALLJP then imgname = 'bg_alljp.png'
    end
    @bg_img = Image.load("../image/game_bg.png")
    @start = Image.load("../image/kaishi.png")
    @img_shimane = Image.load("../image/shimane.png")
    @img_enemy = Image.load("../image/"+imgname)
    @mayor = Mayor.new(135,392) #市長
    @agent = EnemyMayor.new(550,392) #敵市長

    @citizens = []#市民たち
    
    #    @item_img = Image.load("./../image/fall_item/kani.png").setColorKey([0, 255, 0])
    #    @item_img2 = Image.load("./../image/fall_item/yamata.png").setColorKey([0, 255, 0]) # i_okane.png, i_shijimi.pngを追加したい.
    #    @item_img3 = Image.load("./../image/fall_item/rakuda.png").setColorKey([0, 255, 0])
    @bullet = nil #弾丸
    
    #タイマー用変数群の宣言
    @font  = Font.new(40)
    @count_timer = 10
    @i = 0
    @min = 0
    @sec = 0
    @click = 0
    setup
    
    Item.resetpoint
  end
  
  def setup
    @items1 = []#味方のアイテム群
    @items2 = []#敵側のアイテム群
    w = Window.width/2
    d = 30
    10.times do |i|
      @citizens << Citizen.new(rand(w-d*2)+d, true)
      @citizens << Citizen.new(rand(w-d*2)+w+d, false)
    end
    x, y = Input.mousePosX, Input.mousePosY if Input.mouseDown?(M_LBUTTON) 
    @a = 0
    @start_x = 800
    @start_y = 0
    #スプライトクラスのオブジェクトを設定（ボタン、擬似クリック用ポインタ）
    @img_next = Sprite.new(275,250, Image.load(File.expand_path("../../image/next.png", __FILE__)))
    @img_end = Sprite.new(275,450, Image.load(File.expand_path("../../image/end.png", __FILE__)))
    @img_title = Sprite.new(275,350, Image.load(File.expand_path("../../image/img_title.png", __FILE__)))
    @pt = Sprite.new(x,y, Image.load(File.expand_path("../../image/pt_1.png", __FILE__)))
    @count_timer = 30
    @click = 0
  end

  # 出現アイテムを配列に追加
  def add_item
    @item_array_size = 12
    
    if (@items1.size <= @item_array_size) and (0 < (rand(100.0)+1.0).abs and (rand(100.0)+1.0).abs < 1.5)
      x_origin, y_origin = (25..375).to_a.shuffle.first, 15
      
      #確率に応じたアイテム生成
      posarr = [40,40,20]
      flag = rand(posarr.inject{|sum, n| sum + n })
      sum = 0.0
      count = 1
      
      #アイテム決定
      posarr.each do |e|  
        sum += e
        break if flag < sum
        count += 1
      end
      tmp = nil
      case count
      when 1 then tmp = Shijimi.new(x_origin,y_origin)
      when 2 then tmp = Money.new(x_origin,y_origin)
      else tmp = Orochi.new(x_origin,y_origin)
      end
      
      @items1 << tmp
    end
    
    if (@items2.size <= @item_array_size) and (0 < (rand(100.0)+1.0).abs and (rand(100.0)+1.0).abs < 1.5)
      x_origin, y_origin = (475..(Window.width - 25)).to_a.shuffle.first,15
      
      #確率に応じたアイテム生成
      posarr = [40,40,20]
      flag = rand(posarr.inject{|sum, n| sum + n })
      sum = 0.0
      count = 1
      
      #アイテム決定
      posarr.each do |e|  
        sum += e
        break if flag < sum
        count += 1
      end
      tmp = nil
      case count
      when 1 then tmp = Pear.new(x_origin,y_origin)
      when 2 then tmp = Crab.new(x_origin,y_origin)
      else tmp = Camel.new(x_origin,y_origin)
      end
      @items2 << tmp
    end	
  end

  #擬似ポインタをクリック先に移動
  def update(a)
    @pt.x, @pt.y = Input.mousePosX, Input.mousePosY
    if a == 1
	    @count_timer = 0
      @click = 0
      unless @modeint == ALLJP
        @img_next.draw
      end
      @img_end.draw
      @img_title.draw
      @a = 0
    end
    @start_x = @start_x -20 if @start_x > -800
    
    #タイマー
    @min = @count_timer / 60
    @sec = @count_timer % 60
    @i += 1
    if @i == 59 then 
      @i = 0
      @count_timer -= 1
      @click, @a = 1, 1 if @count_timer <= 0
    end
    if @sec <= 9 then Window.drawFont(365, 200, "#{@min}:0#{@sec}", @font, :color => [0, 0, 0])
    else Window.drawFont(365, 200, "#{@min}:#{@sec}", @font, :color => [0, 0, 0])
    end
  end

  def play
    #ESCでトップへ戻る
    Scene.set_scene(:game) if Input.keyPush?(K_SPACE) 
    
    #背景などの描画
    Window.draw(0, 0, @bg_img)
    Window.draw(25,25, @img_shimane)
    Window.draw(450, 25, @img_enemy)
    
    #アイテム追加
    self.add_item
    @citizens.each {|item| @citizens.delete(item) if item.isItemTrue and (item.x < 0 or Window.width < item.x)}
    
    #中断メニュー表示処理
    @a = 1 if Input.keyDown?(K_Y) 
    self.update(@a)
    
    #コンティニューとENDボタン、擬似ポインタの表示
    @pt.draw
    Window.draw(@start_x,@start_y,@start)
    
    @bullets_agent = [Bullet.new(@agent.x, @agent.y, 0.0, Window.height-300, Window.width/2, Window.width, true)] if rand(25) == 2
    #ボタン処理（次の画面への遷移）
    if Input.mouseDown?(M_LBUTTON) then
      # 中断メニューが出ている時のマウスクリックイベント
      Scene.set_scene(@nextscene) unless @pt.check([@img_next]).empty?
      Scene.finish unless @pt.check(@img_end).empty?
      Scene.set_scene(:title) unless @pt.check([@img_title]).empty?
      setup if @click == 1	
        
      # 通常のマウスクリックイベント(玉生成)
      @bullets = [Bullet.new(@mayor.x, @mayor.y, 0.0, Window.height,0.0, Window.width/2, false)] if Input.mouseDown?(M_LBUTTON) 
    end
    
    #玉とアイテムの衝突判定
    Sprite.check(@bullets, @items1)
    Sprite.check(@bullets, @items2)
    
    #アイテムと市民の衝突判定
    Sprite.check(@items1, @citizens)
    Sprite.check(@items2, @citizens)
    
    #ポイント描画
    Window.drawFont(50,50, Item.get_friendpoint.to_s + "万人", Font.new(24))
    
    #アップデート、ドロー、クリア
    Sprite.update([@items1, @items2, @mayor, @bullets, @citizens, @agent, @bullets_agent])
    Sprite.draw([@items1, @items2, @mayor, @bullets, @agent, @bullets_agent])
    Sprite.clean([@items1,@items2,@bullets, @bullets_agent])
  end
end