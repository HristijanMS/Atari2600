extends Bullet

func _on_area_2d_body_entered(body: Node2D) -> void: #take damage from Enemy 
	if body.is_in_group("Enemy"):
		body.take_damage()
		queue_free()
	elif body.is_in_group("Wall") or body.is_in_group("EWall"):#destroy on wall
		queue_free()
