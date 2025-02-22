extends CharacterBody2D


@onready var animation:AnimatedSprite2D=$AnimatedSprite2D
@onready var camera:Camera2D=$Camera2D
@onready var bullet:Object=preload("res://Player/player_bullet.tscn")
@onready var stunTimer:Timer=$StunTimer

var score:int=0 #changed in sample.gd
var health:int=3
var regeneration:int=0#changed in sample.gd

var SPEED:float=65.0

var dir:Vector2
var default_dir:Vector2=Vector2(1,0)

func add_health()->void: #when you collect 3 samples +1 health(sample.gd)
	health+=1

func take_damage()->void: #activated in enemy_bullet.gd
	health-=1

func stun()->void:#bullet from boss enemy 3 stuns you
	SPEED=30
	stunTimer.start()
	
func move()->void: 
	dir=Input.get_vector("LEFT","RIGHT","UP","DOWN")
	velocity=SPEED*dir
	
	if Input.is_action_just_pressed("LEFT"): 
		animation.flip_h=true
	elif Input.is_action_just_pressed("RIGHT"):
		animation.flip_h=false
		
	if velocity!=Vector2(0,0):
		animation.play()
	else:
		animation.stop()
		animation.frame=0
		
	if dir!=Vector2(0,0):#get the last direction for shooting
		default_dir=dir

	
func shoot()->void:
	var projectile:Object=bullet.instantiate()
	projectile.pos=self.global_position
	projectile.dir=self.default_dir
	get_parent().call_deferred("add_child", projectile) # add bullet to main scene to be unaffected by childs movement
	

func _physics_process(_delta: float) -> void:
	move()
	move_and_slide()
	if Input.is_action_just_pressed("SHOOT"):
		$Shoot.play()
		shoot()
	if health<=0:#death
		queue_free()
		get_tree().reload_current_scene()


func _on_stun_timer_timeout() -> void:
	SPEED=65
