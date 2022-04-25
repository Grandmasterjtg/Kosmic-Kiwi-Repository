extends Node2D

onready var interactable = $Interactable

var m_in_area := false
var m_current_ship_visual_index := 0

var penguin_scene = preload("res://Scenes/Characters/Penguin.tscn")
var stinky_scene = preload("res://Scenes/Characters/Stinky.tscn")
var seal_scene = preload("res://Scenes/Characters/Seal.tscn")

signal interacted

func _ready() -> void:
	# resource setup
	interactable.connect("interacted", self, "_on_interact")
	interactable.connect("entered", $ButtonDisplay, "toggle_display")
	interactable.connect("exited", $ButtonDisplay, "toggle_display")
	
	# indicator setup
	interactable.connect("entered", $EmoteBubble, "open_bubble")
	interactable.connect("exited", $EmoteBubble, "close_bubble")
	
	# setup ship visuals
	check_ship_parts()
	
	# setup friend placement
	setup_friend_homes()
	check_friend_placement()

func _on_interact() -> void:
	emit_signal("interacted")
	check_ship_parts()

func check_ship_parts():
	if (Inventory.item_exists_in_inventory("Engine")):
		m_current_ship_visual_index = 1
		if (Inventory.item_exists_in_inventory("Solar Sail")):
			m_current_ship_visual_index = 2
			if (Inventory.item_exists_in_inventory("Shield")):
				m_current_ship_visual_index = 3
				if (Inventory.item_exists_in_inventory("Shield") and Inventory.item_exists_in_inventory("Solar Sail")):
					m_current_ship_visual_index = 4
	update_ship_visual(m_current_ship_visual_index)

func update_ship_visual(index: int):
	match m_current_ship_visual_index:
		0:
			$AnimatedSprite.animation = "ship_0"
		1:
			$AnimatedSprite.animation = "ship_1"
		2:
			$AnimatedSprite.animation = "ship_2"
		3:
			$AnimatedSprite.animation = "ship_3"
		4:
			$AnimatedSprite.animation = "ship_4"
	$AnimatedSprite.play()

func setup_friend_homes():
	# setup penguin
	if !get_tree().get_nodes_in_group("penguin").empty():
		get_tree().get_nodes_in_group("penguin")[0].set_home_position($PenguinHome.global_position)
	
	# setup stinky
	if !get_tree().get_nodes_in_group("stinky").empty():
		get_tree().get_nodes_in_group("stinky")[0].set_home_position($StinkyHome.global_position)
	
	# setup seal
	if !get_tree().get_nodes_in_group("seal").empty():
		get_tree().get_nodes_in_group("seal")[0].set_home_position($SealHome.global_position)

func check_friend_placement():
	# penguin check
	print("Ship check_friend_placement() for Penguin...")
	if FriendManager.check_friend_joined(FriendManager.FriendID.PENGUIN):
		if get_tree().get_nodes_in_group("penguin").empty():
#			print("creating penguin instance...")
			var friend = penguin_scene.instance()
			get_tree().get_nodes_in_group("level_root")[0].get_node("Actors").add_child(friend)
			friend.global_position = $PenguinHome.global_position
			friend.set_home_position($PenguinHome.global_position)
		else:
			var friend = get_tree().get_nodes_in_group("penguin")[0]
			friend.global_position = $PenguinHome.global_position
			friend.set_home_position($PenguinHome.global_position)
	
	# stinky check
	print("Ship check_friend_placement() for Stinky...")
	if FriendManager.check_friend_joined(FriendManager.FriendID.STINKY):
		if get_tree().get_nodes_in_group("stinky").empty():
#			print("creating penguin instance...")
			var friend = stinky_scene.instance()
			get_tree().get_nodes_in_group("level_root")[0].get_node("Actors").add_child(friend)
			friend.global_position = $StinkyHome.global_position
			friend.set_home_position($StinkyHome.global_position)
		else:
			var friend = get_tree().get_nodes_in_group("stinky")[0]
			friend.global_position = $StinkyHome.global_position
			friend.set_home_position($StinkyHome.global_position)
	
	# seal check
	print("Ship check_friend_placement() for Seal...")
	if (FriendManager.check_friend_joined(FriendManager.FriendID.SEAL)):
		if get_tree().get_nodes_in_group("seal").empty():
			var friend = seal_scene.instance()
			get_tree().get_nodes_in_group("level_root")[0].get_node("Actors").add_child(friend)
			friend.global_position = $SealHome.global_position
			friend.set_home_position($SealHome.global_position)
		else:
			var friend = get_tree().get_nodes_in_group("seal")[0]
			friend.global_position = $SealHome.global_position
			friend.set_home_position($SealHome.global_position)





