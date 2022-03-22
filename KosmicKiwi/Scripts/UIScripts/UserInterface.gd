extends CanvasLayer

const INVENTORY = "inventory"

var textures = load("res://ArtAssets/Temp/")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed(INVENTORY):
		$InventoryUI.visible = !$InventoryUI.visible
#		if $InventoryUI.visible == true:
#			$InventoryUI.update_inventory()
