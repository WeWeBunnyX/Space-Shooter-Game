extends Control
var pLifeIcon:= preload("res://MainScenes/life_icon.tscn")

@onready var lifeContainer:=$LifeContainer

func _ready():
	clearLives()
	
	Signals.connect("on_player_life_change", _on_player_life_change)
	
func clearLives():
	for child in lifeContainer.get_children():
		#lifeContainer.remove_child(child)
		child.queue_free()

func setLives(lives: int):
	clearLives()
	for i in range(lives):
		lifeContainer.add_child(pLifeIcon.instantiate())

func _on_player_life_change(life: int):
	setLives(life)
	
