extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body is player:
		Global.moneda+=1
		print(Global.moneda)
		
		queue_free()
		
