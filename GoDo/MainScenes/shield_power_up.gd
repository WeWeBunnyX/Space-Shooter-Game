extends Powerup

@export var ShieldTime:float = 6

func applyPowerUp(player:Player):
	player.applyShield(ShieldTime)
