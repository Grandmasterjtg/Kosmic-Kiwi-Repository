extends Node2D


var m_mouse_object = null

var m_clamp = false
const RANGE = 300


# Called when the node enters the scene tree for the first time.
func _ready():
	MouseManager.connect("mouse_updated", self, "set_cursor_texture")
	MouseManager.connect("mouse_object_updated", self, "set_cursor_object")
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


# takes a texture
# sets the mouse's sprite texture to the texture
# if a mouse object exists, delete it and set it to null
func set_cursor_texture(texture):
	# if the texture is null, use the default cursor
	if texture == null:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	# if there is a mouse object, remove it
	if m_mouse_object != null:
		m_mouse_object.queue_free()
		m_mouse_object = null
	
	# set the texture of the mouse
	$Sprite.texture = texture

# takes an instance of a scene
# sets the mouse to this object
# if the mouse had a texutre, set it to null
func set_cursor_object(object, texture_visible=true):
	if object != null:
		# append the object to the mouse object
		m_mouse_object = object
		add_child(object)
		
		# if the mouse texture should not be shown
		if !texture_visible:
			$Sprite.texture = null
			
		# set the cursor to invisible
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	else:
		set_cursor_texture(null)


func set_clamp(value : bool):
	m_clamp = value

