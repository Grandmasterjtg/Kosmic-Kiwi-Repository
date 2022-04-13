extends Node2D

var m_clamp = false
const RANGE = 300

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	MouseManager.connect("mouse_updated", self, "set_cursor")
	MouseManager.connect("new_clamp", self, "set_clamp")
	MouseManager.reset_mouse_texture()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if m_clamp:
		var player_position_canvas = PlayerManager.get_player().get_global_transform_with_canvas().origin
		var item_direction = player_position_canvas.direction_to(get_global_mouse_position())
		var item_distance = player_position_canvas.distance_to(get_global_mouse_position())
		item_distance = min(item_distance, RANGE)
		self.position = player_position_canvas + item_direction * item_distance
		get_viewport().warp_mouse(self.position)
	else:
		self.position = self.get_global_mouse_position()
	print(self.position)
	
func set_cursor(texture):
	if texture == null:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$Sprite.texture = texture
	
func set_clamp(value : bool):
	m_clamp = value
