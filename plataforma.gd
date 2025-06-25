extends Area2D

enum TipoPlataforma {FIJA, OSCILATORIA, FRAGIL, REBOTE}
@export var type: TipoPlataforma = TipoPlataforma.FIJA;
@export var fuerza_rebote := 2.0



func _ready() -> void:
	actualizar_plataforma()
	monitorable = true
	monitoring = true
	
func actualizar_plataforma():
	match type:
		TipoPlataforma.FIJA:
			$Sprite2D.modulate = Color.GREEN
		TipoPlataforma.OSCILATORIA:
			$Sprite2D.modulate = Color.BLUE
		TipoPlataforma.FRAGIL:
			$Sprite2D.modulate = Color.RED
		TipoPlataforma.REBOTE:
			$Sprite2D.modulate = Color.YELLOW
			
