class Scene
  @@scenes = {}
  @@current_scene_name = nil

  def self.add_scene(name, obj)
    @@scenes[name.to_sym] = obj
  end

  def self.set_scene(scene_name)
    @@current_scene_name = scene_name.to_sym
  end

  def self.play
    @@scenes[@@current_scene_name].play
  end
end