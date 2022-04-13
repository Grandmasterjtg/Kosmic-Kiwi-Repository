extends Node2D

export var player_speed : float

func _ready():
	$PlayerBody.set_speed(player_speed)
