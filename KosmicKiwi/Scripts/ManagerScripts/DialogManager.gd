extends Node

var m_tutorial_states = {
	"Fiber": { "should_play": true, "dialogue": "Tutorial_Crafting" },
	"Rope": { "should_play": true, "dialogue": "Tutorial_Gadget" },
	"Friend": { "should_play": true, "dialogue": "Tutorial_Friend"},
	"Forest": { "should_play": true, "dialogue": "Arrive_Forest"},
	"Desert": { "should_play": true, "dialogue": "Arrive_Desert"},
	"Wet": { "should_play": true, "dialogue": "Arrive_Wet"},
	"Warp Core": { "should_play": true, "dialogue": "End_Game"},
	"Engine": { "should_play": true, "dialogue": "Tutorial_ShipParts"}
}

func get_tutorial_state(key: String) -> bool:
	if m_tutorial_states.has(key):
		return m_tutorial_states[key]["should_play"]
	else:
		return false

func set_tutorial_state(key: String, state: bool):
	if m_tutorial_states.has(key):
		m_tutorial_states[key]["should_play"] = state

func play_dialog(key: String):
	if m_tutorial_states.has(key) and m_tutorial_states[key]["should_play"]:
		var dialog = Dialogic.start(m_tutorial_states[key]["dialogue"])
		get_tree().get_nodes_in_group("canvas")[0].add_child(dialog)
		set_tutorial_state(key, false)

func play_end_game_dialog():
	var dialog = Dialogic.start("End_Game")
	get_tree().get_nodes_in_group("canvas")[0].add_child(dialog)

func open_nav_menu_finale():
	get_tree().get_nodes_in_group("canvas")[0].get_node("NavMenu").open_menu()
