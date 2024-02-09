class_name Powerup
extends Area2D

@export var powerupMoveSpeed:float=50

func _physics_process(delta):
	position.y+=powerupMoveSpeed*delta
	
func applyPowerUp(player:Player): # Implemented in Shield Power Up inherited script
	pass

func _on_area_entered(area):
	if area is Player:
		applyPowerUp(area)
		
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()



