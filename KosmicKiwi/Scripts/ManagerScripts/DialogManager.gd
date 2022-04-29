extends Node

var m_tutorial_states = {
	"Fiber": { "state": true, "dialogue": "Tutorial_Crafting" },
	"Rope": { "state": true, "dialogue": "Tutorial_Gadget" },
	"Friend": { "state": true, "dialogue": "Tutorial_Friend"}
}

var m_arrival_states = {
	"Forest": { "traveled_to": false, "dialogue": "Arrive_Forest"},
	"Desert": { "traveled_to": false, "dialogue": "Arrive_Desert"}
}

signal dialog_started

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

func play_planet_arrive_dialog(key: String):
	if m_arrival_states.has(key) and !m_arrival_states[key]["traveled_to"]:
		var dialog = Dialogic.start(m_arrival_states[key]["dialogue"])
		get_tree().get_nodes_in_group("canvas")[0].add_child(dialog)
		set_tutorial_state(key, true)
		emit_signal("dialog_started")
