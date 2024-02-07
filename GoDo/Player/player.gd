extends Area2D

var plBullet:= preload("res://MainScenes/bullet.tscn")

@onready var AnimatedSprite:=$AnimatedSprite2D
# Exporting the 'speed' variable
@onready var firingPositions:=$FiringPositions
#FireDelay Timer
@onready var firedelay:=$FireDelay

@export var speed: float = 100
@export var FireDelayTimer : float=0.1
var vel: Vector2 = Vector2(0, 0)

func _process(delta):
	if vel.x<0:
		AnimatedSprite.play("left")
	elif vel.x>0:
		AnimatedSprite.play("right")
	else :
		AnimatedSprite.play("Straight")
		
	#Check if shooting
	if Input.is_action_pressed("shoot") and firedelay.is_stopped():
		firedelay.start(FireDelayTimer)
		for child in firingPositions.get_children():
			var bullet:=plBullet.instantiate()
			bullet.global_position = child.global_position
			get_tree().current_scene.add_child(bullet)

func _physics_process(delta):
	var dirVec = Vector2(0, 0)
	
	if Input.is_action_pressed("move_left"):
		dirVec.x = -1
	elif Input.is_action_pressed("move_right"):
		dirVec.x = 1
	elif Input.is_action_pressed("move_up"):
		dirVec.y = -1
	elif Input.is_action_pressed("move_down"):
		dirVec.y = 1

	vel = dirVec.normalized() * speed
	position += vel * delta

#Remain within screen
	var viewRect:= get_viewport_rect()
	position.x=clamp(position.x, 0 , viewRect.size.x)
	position.y=clamp(position.y, 0 , viewRect.size.y)

