extends CanvasLayer

const INVENTORY = "inventory"
const CRAFT = "craft"

func _process(delta: float) -> void:
	# player toggles inventory panel
	if Input.is_action_just_pressed(INVENTORY):
		$InventoryUI.visible = !$InventoryUI.visible
		$CraftingUI.visible = false
	if Input.is_action_just_pressed(CRAFT):
		$CraftingUI.visible = !$CraftingUI.visible
		$InventoryUI.visible = false
