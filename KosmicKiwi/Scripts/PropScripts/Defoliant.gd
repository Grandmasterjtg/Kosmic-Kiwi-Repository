extends StaticBody2D

const RANGE := 2000

func _ready():
	activate()

func activate():
	var briars = get_tree().get_nodes_in_group("briar")
	for briar in briars:
		if global_position.distance_to(briar.global_position) < RANGE:
			#briar.solve_puzzle()
			pass
