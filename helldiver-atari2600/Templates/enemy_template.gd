extends CharacterBody2D
class_name Enemy
@onready var animation:AnimatedSprite2D=$AnimatedSprite2D
#default class for every enemy
enum States {IDLE, WALKING, ATTACK}

var health:int
var state:States
var direction: int
var speed:int=50
var move_direction:Vector2

# Track distance moved
var distance_moved: float = 0.0
var previous_position: Vector2

func take_damage()->void: 
	if health>0:
		health-=1
	if health==0:
		queue_free()
		
func move()->void:
	var current_position:Vector2 = global_position
	distance_moved += previous_position.distance_to(current_position)
	previous_position = current_position  # Update previous position

	# Stop moving after 300 pixels
	if distance_moved >= 300:
		state=States.IDLE
	
	if direction == 1:
		move_direction= Vector2.RIGHT
		velocity =move_direction * speed
	elif direction == 2:
		move_direction= Vector2.LEFT
		velocity = move_direction * speed
	elif direction == 3:
		move_direction= Vector2.UP
		velocity =move_direction * speed
	elif direction == 4:
		move_direction= Vector2.DOWN
		velocity = move_direction * speed
	move_and_slide()
