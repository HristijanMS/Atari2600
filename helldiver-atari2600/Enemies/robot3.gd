extends Enemy

@onready var bullet: Object = preload("res://Enemies/enemy_bullet_3.tscn")
@onready var cooldownTimer: Object = $Reloading

var player_entered: Object
var rng:Object = RandomNumberGenerator.new()

var cooldown: bool = false


func reload()->void: #function for shooting
	$Shoot.play()
	var projectile: Object = bullet.instantiate()
	projectile.global_position = self.global_position
	projectile.dir = (player_entered.global_position - self.global_position).normalized()
	get_parent().call_deferred("add_child", projectile)
	
func _ready() -> void:
	rng.randomize()
	health = 6
	previous_position = global_position  # Initialize previous position
	direction = rng.randi_range(1, 4)

func _physics_process(_delta: float) -> void:
	if state==States.IDLE:
		animation.play("IDLE")
		direction = 0  # Stop moving
		distance_moved = 0.0  # Reset distance counter
		if player_entered != null:
			state = States.ATTACK
	elif state == States.WALKING:
		move()
		animation.play("WALK")
		if player_entered != null:
			state = States.ATTACK
	elif state == States.ATTACK:
		velocity=Vector2(0,0)
		animation.stop()
		#anim.play("IDLE")
		if player_entered == null:
			state = States.IDLE
		# Handle shooting logic
		if player_entered != null and cooldown == false:
			direction=0
			reload()
			cooldownTimer.start()
			cooldown = true

func _on_reloading_timeout() -> void: #shooting cooldown
	cooldown = false


func _on_detect_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_entered = body


func _on_detect_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_entered = null


func _on_move_timer_timeout() -> void: #autostart timer for moving
	if distance_moved < 300 and state==States.IDLE:
		state=States.WALKING
		direction = rng.randi_range(1, 4)
