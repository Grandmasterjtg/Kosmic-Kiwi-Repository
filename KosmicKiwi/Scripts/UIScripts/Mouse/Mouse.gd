extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	MouseManager.connect("mouse_updated", self, "set_cursor")
	MouseManager.reset_mouse_texture()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position = self.get_global_mouse_position()
	
func set_cursor(texture):
	if texture == null:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$Sprite.texture = texture
