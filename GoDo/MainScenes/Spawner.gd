extends Node2D
var preloadEnemies:= [
	preload("res://MainScenes/fast_enemy.tscn"),
	preload("res://MainScenes/slow_shooter.tscn"),
	preload("res://MainScenes/bouncer_enemy.tscn")
]

var plMeteor:=preload("res://MainScenes/meteor.tscn")
@onready var spawnTimer:=$SpawnerTime

@export var MIN_SPAWN_TIME=1.5
var nextSpawnTime:=5.0

func _ready():
	randomize()
	spawnTimer.start(nextSpawnTime)


func _on_spawner_time_timeout():
	#Spawn an enemy
	var viewRect:=get_viewport_rect()
	var xPos:=randi_range(viewRect.position.x, viewRect.end.x) #Func to avoid spawning of enemies on extreme left of screen
	
	if randf()<0.3:                                #10% chances of meteor spawning
		var meteor:=plMeteor.instantiate()
		meteor.position=Vector2(xPos,position.y)
		get_tree().current_scene.add_child(meteor)
	
	
	var enemyPreload= preloadEnemies[randi()% preloadEnemies.size()]
	var Enemy=enemyPreload.instantiate()
	Enemy.position= Vector2(xPos, position.y)
	get_tree().current_scene.add_child(Enemy)
	#Restart timer
	nextSpawnTime-=0.1               # Spawn rate of enemies increases as time progresses
	if nextSpawnTime<MIN_SPAWN_TIME:       
		nextSpawnTime=MIN_SPAWN_TIME  
	spawnTimer.start(nextSpawnTime)
