extends CPUParticles2D

func _ready():
	emitting=true     #Did this because by default we oneshot+emitting no possible at same time
					  #https://youtu.be/d3XJLQEr_SM?feature=shared&t=390

func _process(delta):
	if !emitting:              # To prevent building up of particles in game
		queue_free() 
