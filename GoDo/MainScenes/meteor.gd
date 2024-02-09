extends Area2D
var pMeteorEffect:=preload("res://MainScenes/meteor_effect.tscn")
@export var minSpeed: float=10
@export var maxSpeed: float=20
@export var minRotation: float=-10
@export var maxRotation: float=10

@export var life: int=20

var speed: float=0
var rotationRate: float=0
var PlayerinArea: Player=null

func _ready():
	speed= randf_range(minSpeed, maxSpeed)
	rotationRate=randf_range(minRotation, maxRotation)

func _process(delta):                  
	if PlayerinArea!=null:
		PlayerinArea.damage(1)      #Touch the meteor and boom, see line 38 and 43
	
	
	
func _physics_process(delta):
	rotation_degrees+=rotationRate*delta # In degrees , whereas rotation function is in radians

	position.y+=speed*delta

func damage(amount: int):
	if life<=0: #https://www.youtube.com/watch?v=sYHiMJe1HcQ&list=PLah6faXAgguPlyHWM5G9in10UzRcdeb2R&index=32
		return    #No duplicate score effect

	life-=amount
	if life<=0:
		var effect:=pMeteorEffect.instantiate()     #Meteror break effect
		effect.position=position                    #Meteror break effect
		get_parent().add_child(effect)              #Meteror break effect         
		Signals.emit_signal("on_score_increment", 2)
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_Meteor_area_entered(area):     
	if area is Player:
		PlayerinArea=area


func _on_area_exited(area):        
	if area is Player:
		PlayerinArea=null
