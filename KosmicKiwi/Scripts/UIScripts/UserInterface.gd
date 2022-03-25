extends CanvasLayer

const INVENTORY = "inventory"

func _process(delta: float) -> void:
	if Input.is_action_just_pressed(INVENTORY):
		$InventoryUI.visible = !$InventoryUI.visible
