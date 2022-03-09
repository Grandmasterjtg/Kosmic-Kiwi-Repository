extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


export var m_speed := 100.0
var m_direction := Vector2(0, 1)

func _physics_process(delta) -> void:
	var horizontal_movement = m_speed * delta
	var vertical_movement = m_speed * delta
	move_local_x(horizontal_movement)
	move_local_y(vertical_movement)
