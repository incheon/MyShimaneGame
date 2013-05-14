class Map
  def initialize(map_file)
    @chips = Image.loadToArray(File.join(File.dirname(__FILE__), "..", "images", "map_chips.png"), 4, 4)
    @map_data = []
    puts map_file
    File.open(map_file).each do |line|
      @map_data << line.chomp.split(/\s*,\s*/)
    end
    @map_width = 8
    @map_height = 8
    @c_w = @chips.first.width
    @c_h = @chips.first.height
  end

  def draw
    @map_height.times do |my|
      @map_width.times do |mx|
        Window.draw((mx * @c_w),
                    (my * @c_h),
                    @chips[@map_data[my][mx].to_i])
      end
    end
  end
end
