extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready():
	# Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	MouseManager.connect("mouse_updated", self, "set_cursor")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position = self.get_global_mouse_position()
	
func set_cursor(texture):
	$Sprite.texture = texture
