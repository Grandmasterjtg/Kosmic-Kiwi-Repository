extends Friend

const ITEM_NAME = "Foam Charge"
const PLACE := "place"
const CANCEL := "cancel"
const FOAM_TEXTURE = preload("res://ArtAssets/ItemIcons/Foam.png")
const PENGUIN_HAPPY_TEXTURE = preload("res://ArtAssets/Characters/emotes/penguinhappy.png")
const ITEM_SCENE_PATH = "res://Scenes/Props/Items/Foam.tscn"

var m_showing_icon := false

func _ready() -> void:
	self.friend_id = 0

func _input(event):
	if event.is_action_pressed(CANCEL) and m_showing_icon:
		cancel_ability()
	if event.is_action_released(PLACE) and m_showing_icon and UIManager.menus_closed():
		place_ability()

func use_ability():
	if FriendManager.get_current_friend_id() == self.friend_id and !FriendManager.friend_ability_on_cooldown():
		print("Penguin ability used!")
		FriendManager.start_friend_ability()
		if !m_showing_icon and UIManager.menus_closed():
			show_ability()
			$EmoteBubble.open_bubble_with_texture(PENGUIN_HAPPY_TEXTURE)

func show_ability():
	MouseManager.set_mouse_texture(FOAM_TEXTURE)
	MouseManager.set_clamp(true)
	m_showing_icon = true


func cancel_ability():
	MouseManager.reset_mouse_texture()
	MouseManager.set_clamp(false)
	m_showing_icon = false


func place_ability():
	# null checks
	var ability_scene = load(ITEM_SCENE_PATH)
	if ability_scene != null:
		var ability = ability_scene.instance()
		# add the item to the scene
		get_tree().root.add_child(ability)
		# initialize the item script to the correct item and position
		ability.global_position = MouseManager.get_mouse_pos()
		ability.activate()
		
	# reset mouse cursor
	MouseManager.reset_mouse_texture()
	MouseManager.set_clamp(false)
	m_showing_icon = false


