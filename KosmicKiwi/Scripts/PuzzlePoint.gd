extends TileMap

onready var m_obstacle = $Obstacle
export var m_correct_item : String

func _ready():
	$Area2D.connect("area_entered", self, "_on_CollisionShape2D_collided")

func remove_obstacle():
	m_obstacle.queue_free()

func _on_CollisionShape2D_collided(area : Area2D):
	if m_obstacle != null and area.get_parent().get_item_name() == m_correct_item:
		remove_obstacle()
