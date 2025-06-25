extends Node

var moneda := 0 :
	set(val):
		moneda = val
		if player != null:
			player.actualizaInterfazMoneda()
			$monedasonido.play()
	get:
		return moneda

var player
