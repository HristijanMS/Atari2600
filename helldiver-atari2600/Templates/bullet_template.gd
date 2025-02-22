extends CharacterBody2D
class_name Bullet

var pos:Vector2 #set in player.gd
var dir:Vector2 #set in player.gd
var SPEED:int=200

func _ready()->void:
	global_position=pos #set bullet global pos

func _physics_process(delta: float) -> void:
	velocity = dir * SPEED * delta
	move_and_collide(velocity)  # Move the bullet
