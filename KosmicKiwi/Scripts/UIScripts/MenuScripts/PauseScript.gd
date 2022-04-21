extends Control

const ACTION_PAUSE := "pause"

onready var pause_menu := get_node("PauseMenu")
onready var controls_menu := get_node("ControlsMenu")
onready var settings_menu := get_node("SettingsMenu")

func _input(event) -> void:
	if event.is_action_pressed(ACTION_PAUSE):
		toggle_paused()

func toggle_paused() -> void:
	get_tree().paused = !get_tree().paused
	if get_tree().paused:
		pause_menu.visible = true
	else:
		pause_menu.visible = false
		controls_menu.visible = false
		settings_menu.visible = false

func _on_Back_pressed():
	pause_menu.visible = true
	controls_menu.visible = false
	settings_menu.visible = false

func _on_Controls_pressed():
	pause_menu.visible = false
	controls_menu.visible = true
	
func _on_Exit_pressed():
	get_tree().quit()

func _on_Resume_pressed():
	toggle_paused()
	
func _on_Settings_pressed():
	pause_menu.visible = false
	settings_menu.visible = true
