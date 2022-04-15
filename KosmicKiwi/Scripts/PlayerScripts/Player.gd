extends Node2D

export var player_speed : float

onready var body = $PlayerBody
onready var bubble = $EmoteBubble

func _ready():
	$PlayerBody.set_speed(player_speed)
