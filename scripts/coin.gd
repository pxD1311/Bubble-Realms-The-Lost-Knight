extends Area2D


@onready var animation_player = $AnimationPlayer

func _on_body_entered(_body):
	GameManager.add_coin()
	animation_player.play("pickup")
	
