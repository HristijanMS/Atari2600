extends Node2D

@export var target_scene_path: String = "res://cutscene.tscn"

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		call_deferred("_change_scene")

func _change_scene() -> void:
	get_tree().change_scene_to_file(target_scene_path)

func _on_stats_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$Player/Camera2D/Score.visible=false
		$Player/Camera2D/HP.visible=false

func _on_stats_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$Player/Camera2D/Score.visible=true
		$Player/Camera2D/HP.visible=true
