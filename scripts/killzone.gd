extends Area2D



func _on_body_entered(body):
	if body.name == "Character":  # Adjust for your player node's name
		GameManager.handle_kill_zone(body)
