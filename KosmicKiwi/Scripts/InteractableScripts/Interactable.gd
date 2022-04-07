extends Area2D

# interaction variables
var m_in_area := false
const INTERACT := "interact"

export var interact_radius := 50
export var interact_height := 70

var collision_shape

signal interacted
signal entered
signal exited

func _ready():
	# collision_shape setup
	collision_shape = $CollisionShape2D
	collision_shape.get_shape().set_radius(interact_radius)
	collision_shape.get_shape().set_height(interact_height)
	
	# signal setup
	self.connect("body_entered", self, "_on_body_entered")
	self.connect("body_exited", self, "_on_body_exited")
	
func _process(delta):
	if m_in_area and Input.is_action_just_pressed(INTERACT):
		emit_signal("interacted")
	
func _on_body_entered(body) -> void:
	m_in_area = true
	emit_signal("entered")
	
func _on_body_exited(body) -> void:
	m_in_area = false
	emit_signal("exited")
	
func is_in_area() -> bool:
	return m_in_area
