extends Node2D
var preloadEnemies:= [
	preload("res://MainScenes/fast_enemy.tscn"),
	preload("res://MainScenes/slow_shooter.tscn"),
	preload("res://MainScenes/bouncer_enemy.tscn")
]

var preloadedPowerUps:= [
	preload("res://MainScenes/shield_power_up.tscn"),
	preload("res://MainScenes/rapid_power_up.tscn")
]

var plMeteor:=preload("res://MainScenes/meteor.tscn")
@onready var spawnTimer:=$SpawnerTime
@onready var powerUpSpawnTimer:=$PowerUpSpawnTimer

@export var MIN_SPAWN_TIME=1.5
@export var nextSpawnTime:=5.0
@export var minPowerUpSpawnTime:=3
@export var maxPowerUpSpawnTime:=3


func _ready():
	randomize()
	spawnTimer.start(nextSpawnTime)
	powerUpSpawnTimer.start(minPowerUpSpawnTime)
	
func getrandomSpawnPosition(): 
	var viewRect:=get_viewport_rect()
	var xPos:=randi_range(viewRect.position.x, viewRect.end.x) 
	return Vector2(xPos, position.y)
	


func _on_spawner_time_timeout():
	#Spawn an enemy
	#var viewRect:=get_viewport_rect()
	#var xPos:=randi_range(viewRect.position.x, viewRect.end.x) #Func to avoid spawning of enemies on extreme left of screen
	
	if randf()<0.3:                                #10% chances of meteor spawning
		var meteor:=plMeteor.instantiate()
		meteor.position=getrandomSpawnPosition()
		get_tree().current_scene.add_child(meteor)
	
	else:
		var enemyPreload= preloadEnemies[randi()% preloadEnemies.size()]
		var Enemy=enemyPreload.instantiate()
		Enemy.position= getrandomSpawnPosition()
		get_tree().current_scene.add_child(Enemy)
		#Restart timer
		nextSpawnTime-=0.1               # Spawn rate of enemies increases as time progresses
		
	if nextSpawnTime<MIN_SPAWN_TIME:       
		nextSpawnTime=MIN_SPAWN_TIME  
	spawnTimer.start(nextSpawnTime)


func _on_power_up_spawn_timer_timeout():
	var powerUpPreLoad= preloadedPowerUps[randi()% preloadedPowerUps.size()]
	var powerup:Powerup=powerUpPreLoad.instantiate()
	powerup.position=getrandomSpawnPosition()
	get_tree().current_scene.add_child(powerup)
	powerUpSpawnTimer.start(randf_range(minPowerUpSpawnTime, maxPowerUpSpawnTime))
