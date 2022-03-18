extends Sprite

onready var collection_area := $CollectionArea
onready var button_display := $ButtonDisplay

var in_area := false
const INTERACT = "interact"

func _ready():
	collection_area.connect("body_entered", self, "_on_body_entered")
	collection_area.connect("body_exited", self, "_on_body_exited")
	
func _process(delta):
	if in_area and Input.is_action_just_pressed(INTERACT):
		pass
	
func _on_body_entered(body) -> void:
	button_display.visible = true
	
func _on_body_exited(body) -> void:
	button_display.visible = false
