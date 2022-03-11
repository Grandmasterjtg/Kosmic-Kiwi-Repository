extends Control

var ItemClass = preload("res://TempScene/Item.tscn")
var item = ItemClass.instance()
onready var sprite = $Panel/TextureRect
var display = true

func _ready():
#	if test:
#		get_node("Panel/Sprite").texture = test.m_sprite
	
	pass
		
func _process(delta):
	if Input.is_action_just_pressed("move_down") and item:
		if display:
			sprite.texture = item.m_sprite
			display = !display
		else:
			sprite.texture = null
			display = !display
