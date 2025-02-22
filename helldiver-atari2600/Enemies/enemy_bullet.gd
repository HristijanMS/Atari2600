extends Bullet
#This bullet is used in emeny 1. It takes 1 damage.
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SPEED=75
# Called every frame. 'delta' is the elapsed time since the previous frame.


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.take_damage()
		queue_free()
	if body.is_in_group("EWall") or body.is_in_group("Wall"):
		queue_free()
