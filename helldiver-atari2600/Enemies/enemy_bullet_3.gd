extends Bullet

var player:Object

func _ready() -> void:
	SPEED=140

func _on_hit_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.stun()
		body.take_damage()
		queue_free()
	if body.is_in_group("EWall") or body.is_in_group("Wall"):
		queue_free()
		
