extends Area2D
class_name Player

var plBullet:= preload("res://MainScenes/bullet.tscn")

@onready var AnimatedSprite:=$AnimatedSprite2D
# Exporting the 'speed' variable
@onready var firingPositions:=$FiringPositions
#FireDelay Timer
@onready var invincibilityTimer:=$InvincibilityTimer
@onready var firedelay:=$FireDelayTimer
@onready var RapidFireTimer:=$RapidFireTimer

@onready var shieldSprite:=$Shield

@export var speed: float = 100

@export var normalFireDelay:float = 0.12
@export var rapidFireDelay:float = 0.08
var FireDelayTimer : float= normalFireDelay
@export var DamageInvincibilityTime:=2.0
@export var life : int=3
var vel: Vector2 = Vector2(0, 0)

func _ready(): #Shield function
	shieldSprite.visible=false
	Signals.emit_signal("on_player_life_change", life)

@warning_ignore("unused_parameter")
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

func damage(amount:int):
	if !invincibilityTimer.is_stopped():
		return
		
	applyShield(DamageInvincibilityTime)
	
	#invincibilityTimer.start(DamageInvincibilityTime)  Cut n pasted in applyShield function below
	#shieldSprite.visible=true
	
	life-=amount
	Signals.emit_signal("on_player_life_change", life)
	var cam:=get_tree().current_scene.find_child("Camera2D",true,false)  #Shake camera
	cam.shake(10)
	
	if life<=0:
		queue_free()

func applyShield(time:float):
	invincibilityTimer.start(time+invincibilityTimer.time_left)
	shieldSprite.visible=true
	
func applyRapidFireUp(time:float):
	FireDelayTimer=rapidFireDelay
	RapidFireTimer.start(time+RapidFireTimer.time_left)
	

func _on_invincibility_timer_timeout():   #Disappear Shield when away from meteor after a collision
	shieldSprite.visible=false


func _on_rapid_fire_timer_timeout():
	FireDelayTimer=normalFireDelay
