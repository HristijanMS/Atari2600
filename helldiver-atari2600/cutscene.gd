extends Node2D

@export var target_scene_path: String = "res://main.tscn"
	
func _ready() -> void:#after the scene animation reset level
	$AnimationPlayer.play("Chapter1")
func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	get_tree().change_scene_to_file(target_scene_path)
