extends StaticBody2D

const RANGE := 2000

export var item_to_destroy : String
onready var timer = $Timer

func _ready():
	timer.connect("timeout", self, "destroy")

func activate():
	var items = get_tree().get_nodes_in_group(item_to_destroy)
	for item in items:
		print("Consumable: " + str(item) + " " + str(global_position.distance_to(item.global_position)))
		print(position)
		if global_position.distance_to(item.global_position) < RANGE:
			item.solve_puzzle()

func destroy():
	queue_free()