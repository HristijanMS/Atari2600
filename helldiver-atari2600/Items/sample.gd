extends Sprite2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.score+=1
		body.regeneration=body.score
		if body.regeneration%3==0 and body.health<3: 
			body.add_health()
		queue_free()
