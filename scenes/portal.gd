extends Node2D





func _on_area_2d_area_entered(area: Area2D) -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level_selector.tscn")
