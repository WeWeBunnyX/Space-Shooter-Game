extends enemy

@export var rotationSpeed:=20

func _process(delta):
	super(delta)                                                #This has indeed been changed since this tutorial series has been released on Youtube. You can add `super(delta)` to the FastEnemy's _process(delta) function to call the Enemy's _process function as well. I guess they've made it more similar to how other programming languages handle this. For func _physics_process, it still works as described in the tutorial
																#https://www.youtube.com/watch?v=fly5SXe6Azo&list=PLah6faXAgguPlyHWM5G9in10UzRcdeb2R&index=25
																
	rotate(deg_to_rad(rotationSpeed)*delta)



