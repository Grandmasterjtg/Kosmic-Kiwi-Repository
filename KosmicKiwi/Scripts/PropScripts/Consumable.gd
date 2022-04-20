extends StaticBody2D

export var m_range := 2000

export var item_to_destroy : String
export var only_one := false
onready var timer = $Timer

func _ready():
	timer.connect("timeout", self, "destroy")

func activate():
	var items = get_tree().get_nodes_in_group(item_to_destroy)
	if only_one:
		var min_distance = INF
		var min_index : int
		for i in range(len(items)):
			var distance = global_position.distance_to(items[i].global_position)
			if distance < min_distance:
				min_distance = distance
				min_index = i
		if global_position.distance_to(items[min_index].global_position) < m_range:
			items[min_index].solve_puzzle()
	else:
		for item in items:
			if global_position.distance_to(item.global_position) < m_range:
				item.solve_puzzle()

func destroy():
	queue_free()
