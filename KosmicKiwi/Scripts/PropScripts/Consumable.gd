extends StaticBody2D

const RANGE := 2000

export var item_to_destroy : String
onready var timer = $Timer

func _ready():
	activate()
	timer.connect("timeout", self, "destroy")

func activate():
	var items = get_tree().get_nodes_in_group(item_to_destroy)
	for item in items:
		if global_position.distance_to(item.global_position) < RANGE:
			#item.solve_puzzle()
			pass

func destroy():
	queue_free()
