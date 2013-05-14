require 'dxruby'
image = Image.load('./../image/pt.png')

Window.loop do
	x = Input.mousePosX
	y = Input.mousePosY

	Window.draw(x,y,image)
end