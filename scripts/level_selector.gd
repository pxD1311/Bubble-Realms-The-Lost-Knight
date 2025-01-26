extends Control

func _on_level_1_pressed():
	if GameManager.levels_unlocked >= 1:
		get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")
		GameManager.current_scene_path = "res://scenes/levels/level_1.tscn"


func _on_level_2_pressed():
	if GameManager.levels_unlocked >= 2:
		get_tree().change_scene_to_file("res://scenes/levels/level_2.tscn")
		GameManager.current_scene_path = "res://scenes/levels/level_2.tscn"


func _on_level_3_pressed():
	if GameManager.levels_unlocked >= 3:
		get_tree().change_scene_to_file("res://scenes/levels/level_3.tscn")
		GameManager.current_scene_path = "res://scenes/levels/level_3.tscn"

func _on_level_4_pressed():
	if GameManager.levels_unlocked >= 4:
		get_tree().change_scene_to_file("res://scenes/levels/level_4.tscn")
		GameManager.current_scene_path = "res://scenes/levels/level_4.tscn"


func _on_level_5_pressed():
	if GameManager.levels_unlocked >= 5:
		get_tree().change_scene_to_file("res://scenes/levels/level_5.tscn")
		GameManager.current_scene_path = "res://scenes/levels/level_5.tscn"


func _on_hub_pressed():
	if GameManager.levels_unlocked >= 0:
		get_tree().change_scene_to_file("res://scenes/levels/hub.tscn")
		GameManager.current_scene_path = "res://scenes/levels/hub.tscn"
