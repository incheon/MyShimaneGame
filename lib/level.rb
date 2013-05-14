#coding: SJIS

class Level
  attr_accessor :pref 
  attr_accessor :dist 
  attr_accessor :alljp
  attr_reader :cursorbit
  
  def initialize
    
    downpx = 150
      
    @bg_img=Image.load(File.expand_path("../../image/title.png", __FILE__))#背景画像
    @level_title = "対戦レベル"#タイトル文
    prefimg = Image.load(File.expand_path("../../image/btn_chugoku.png", __FILE__))
    @chugoku=Sprite.new((Window.width-prefimg.width)/2-200,Window.height/2+downpx,prefimg)#県のイメージ
    distimg = Image.load(File.expand_path("../../image/btn_westjp.png", __FILE__))
    @westjp=Sprite.new((Window.width-distimg.width)/2,Window.height/2+downpx,distimg)#地方のイメージ
    jpimg = Image.load(File.expand_path("../../image/btn_alljp .png", __FILE__))
    @alljp=Sprite.new((Window.width-jpimg.width)/2+200,Window.height/2+downpx,jpimg)#全国のイメージ
    back = Image.load(File.expand_path("../../image/back.png", __FILE__))
    @back=Sprite.new(Window.width-back.width,Window.height-back.height,back)#戻るボタン
    @back.scale_x = 0.5#スケール調整(幅)
    @back.scale_y = 0.5#スケール調整(高さ)
    @pt=Sprite.new(0,0,Image.load(File.expand_path("../../image/pt_1.png", __FILE__)))#擬似クリックのための小さなビットマップ
    
  end
  
  def play
    Scene.set_scene(:title) if Input.keyPush?(K_SPACE)#終了条件
    Window.draw(0,0,@bg_img)#バックグラウンドセット
    click = Input.mouseDown?(M_LBUTTON) ? true : false    
    
    #擬似オブジェクトのセット
    @pt.x = Input.mousePosX  # マウスカーソルのx座標
    @pt.y = Input.mousePosY  # マウスカーソルのy座標#
    
    #各スプライトの描画
    Sprite.draw(@pt)#
    Sprite.draw(@chugoku)#
    Sprite.draw(@westjp)#
    Sprite.draw(@alljp)#
    Sprite.draw(@back)#
    
    #ボタン処理（次の画面への遷移）
    if click then 
      Scene.set_scene(:chugoku) unless @pt.check([@chugoku]).empty?
      Scene.set_scene(:westjp) unless @pt.check([@westjp]).empty?
      Scene.set_scene(:alljp) unless @pt.check([@alljp]).empty?
      Scene.set_scene(:title) unless @pt.check([@back]).empty?
    end
  end
end
