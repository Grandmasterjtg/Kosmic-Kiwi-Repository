extends Node

var m_tutorial_states = {
	"Fiber": { "state": true, "dialogue": "Tutorial_Crafting" },
	"Rope": { "state": true, "dialogue": "Tutorial_Gadget" }
	
}

signal dialog_started

func _ready():
	pass # Replace with function body.

func get_tutorial_state(key: String):
	if m_tutorial_states.has(key):
		return m_tutorial_states[key]["state"]
	else:
		return false

func set_tutorial_state(key: String, state: bool):
	if m_tutorial_states.has(key):
		m_tutorial_states[key]["state"] = state

func play_dialog(key: String):
	if m_tutorial_states.has(key) and m_tutorial_states[key]["state"]:
		var dialog = Dialogic.start(m_tutorial_states[key]["dialogue"])
		get_tree().get_nodes_in_group("canvas")[0].add_child(dialog)
		set_tutorial_state(key, false)
		emit_signal("dialog_started")
