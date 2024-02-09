extends Area2D
class_name enemy
@export var verticalSpeed:=10.0
@export var enemyHealth:=5
@onready var firingPositions=$FirePositions

var plBullet:= preload("res://MainScenes/enemy_bullet.tscn")
var plEnemyExplosion:=preload("res://MainScenes/enemy_explosions.tscn")
var playerInArea: Player=null

func _process(delta):
	if playerInArea!=null:
		playerInArea.damage(1)

func _physics_process(delta):
	position.y+=verticalSpeed*delta
	
func fire():
		for child in firingPositions.get_children():
			var bullet:=plBullet.instantiate()
			bullet.global_position = child.global_position
			get_tree().current_scene.add_child(bullet)
	
func damage(amount: int):
	if enemyHealth<=0:        #https://www.youtube.com/watch?v=sYHiMJe1HcQ&list=PLah6faXAgguPlyHWM5G9in10UzRcdeb2R&index=32
		return
	
	enemyHealth-=amount
	if enemyHealth<=0:
		var effect:=plEnemyExplosion.instantiate()
		effect.global_position=global_position
		get_tree().current_scene.add_child(effect)
		
		Signals.emit_signal("on_score_increment", 1)
		
		queue_free()
	

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_area_entered(area):
	if area is Player:
		playerInArea=area


func _on_area_exited(area):
	if area is Player:
		playerInArea=null
