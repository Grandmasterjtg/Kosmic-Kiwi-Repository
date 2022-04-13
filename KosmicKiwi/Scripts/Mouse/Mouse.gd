extends Node2D

var m_mouse_object = null

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	MouseManager.connect("mouse_updated", self, "set_cursor_texture")
	MouseManager.connect("mouse_object_updated", self, "set_cursor_object")
	MouseManager.reset_mouse_texture()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position = self.get_global_mouse_position()

# takes a texture
# sets the mouse's sprite texture to the texture
# if a mouse object exists, delete it and set it to null
func set_cursor_texture(texture):
	if texture == null:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		
	if m_mouse_object != null:
		m_mouse_object.queue_free()
		m_mouse_object = null
	
	$Sprite.texture = texture

# takes an instance of a scene
# sets the mouse to this object
# if the mouse had a texutre, set it to null
func set_cursor_object(object):
	if object != null:
		m_mouse_object = object
		add_child(object)
		$Sprite.texture = null
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	else:
		set_cursor_texture(null)
