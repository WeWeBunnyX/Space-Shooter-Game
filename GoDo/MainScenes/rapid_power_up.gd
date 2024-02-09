extends Powerup

@export var rapidFireTime:float=4
func applyPowerUp(player:Player):
	player.applyRapidFireUp(rapidFireTime)

