extends Enemy

@onready var cooldownTimer: Timer = $Reloading
@onready var moveTimer:Timer=$MoveTimer

var player_entered: Object
var rng:Object = RandomNumberGenerator.new()

var cooldown: bool = false
var attack:bool=false
var flag:bool=true

func move_towards_player() -> void:#move towards player to attack
	if player_entered:
		# Calculate the direction to the player
		var direction_to_player:Vector2 = (player_entered.global_position - global_position).normalized()
		# Move the enemy towards the player
		velocity = (direction_to_player) * speed #* delta
		move_and_slide()
		


func _ready() -> void:
	rng.randomize()
	health=3

func _physics_process(_delta: float) -> void:
	if state==States.IDLE:
		animation.play("IDLE")
		direction = 0  # Stop moving
		distance_moved = 0.0  # Reset distance counter
		if flag==true:
			moveTimer.start()
			flag=false
		if player_entered != null:
			state = States.ATTACK
			animation.stop()
	elif state==States.WALKING:
		move()
		animation.play("WALKING")
		if player_entered != null:
			state = States.ATTACK
			animation.stop()
	elif state==States.ATTACK:
		animation.play("ATTACK")
		if player_entered != null:
			move_towards_player()
			if cooldown==false and attack==true:#attack
				player_entered.take_damage()
				cooldownTimer.start()
				cooldown=true
		else:
			direction=0
			state = States.IDLE


func _on_area_2d_body_entered(body: Node2D) -> void:#detect area
	if body.is_in_group("Player"):
		player_entered = body
		

func _on_area_2d_body_exited(body: Node2D) -> void:#detect area
	if body.is_in_group("Player"):
		player_entered = null


func _on_move_timer_timeout() -> void:
	if distance_moved < 300 and state!=States.ATTACK:
		state=States.WALKING
		direction = rng.randi_range(1, 4)

func _on_reload_timeout() -> void:
	cooldown=false


func _on_attack_area_body_entered(body: Node2D) -> void:#is player in attack area
	if body.is_in_group("Player"):
		speed=0
		attack=true
		$Attack.play()

func _on_attack_area_body_exited(body: Node2D) -> void:#if player exited attack area
	if body.is_in_group("Player"):
		speed=65
		attack=false
		$Attack.stop()
		
