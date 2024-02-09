extends Area2D
var pBulletEffect:=preload("res://MainScenes/bullet_effect.tscn")
@export var speed: float=500

func _physics_process(delta):
	position.y-=speed*delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	 
func _on_area_entered(area):                     # adding this so bullets dont pass through meteor
	if area.is_in_group("damageable"):
		var bulletEffect:=pBulletEffect.instantiate()
		bulletEffect.position=position
		get_parent().add_child(bulletEffect)
		
		var cam:=get_tree().current_scene.find_child("Camera2D",true,false)  #Shake camera
		cam.shake(1)
		
		area.damage(1) 
		queue_free()
