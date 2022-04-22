extends Friend

const ITEM_NAME = "Foam"
const FOAM_TEXTURE = preload("res://ArtAssets/ItemIcons/Foam.png")
const PLACE := "place"
const CANCEL := "cancel"
const PENGUIN_HAPPY_TEXTURE = preload("res://ArtAssets/Characters/emotes/penguinhappy.png")

var m_showing_foam := false

func _ready() -> void:
	self.friend_id = 0

func _input(event):
	if event.is_action_pressed(CANCEL) and m_showing_foam:
		cancel_foam()
	if event.is_action_released(PLACE) and m_showing_foam and UIManager.menus_closed():
		place_foam()

func use_ability():
	if FriendManager.get_current_friend_id() == self.friend_id:
		print("Penguin ability used!")
		if !m_showing_foam and UIManager.menus_closed():
			show_foam()
			$EmoteBubble.open_bubble_with_texture(PENGUIN_HAPPY_TEXTURE)

func show_foam():
	MouseManager.set_mouse_texture(FOAM_TEXTURE)
	MouseManager.set_clamp(true)
	m_showing_foam = true


func cancel_foam():
	MouseManager.reset_mouse_texture()
	MouseManager.set_clamp(false)
	m_showing_foam = false


func place_foam():
	# null checks
	var foam_scene = load("res://Scenes/Props/Items/Foam.tscn")
	if foam_scene != null:
		var foam = foam_scene.instance()
		# add the item to the scene
		get_tree().root.add_child(foam)
		# initialize the item script to the correct item and position
		foam.global_position = MouseManager.get_mouse_pos()
		foam.activate()
		
	# reset mouse cursor
	MouseManager.reset_mouse_texture()
	MouseManager.set_clamp(false)
	m_showing_foam = false


