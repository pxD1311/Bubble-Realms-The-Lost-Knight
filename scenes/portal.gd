extends Node2D

@onready var area_2d: Area2D = $Area2D
@export var exit: bool
func _process(_delta):
	# Get a list of all bodies overlapping with the Area2D
	var overlapping_bodies = area_2d.get_overlapping_bodies()
	
	# Check if any of the overlapping bodies is a CharacterBody2D
	for body in overlapping_bodies:
		if body is CharacterBody2D:
			# Change the scene if a CharacterBody2D is detected
			get_tree().change_scene_to_file("res://scenes/levels/level_selector.tscn")
			if exit:
				GameManager.player_stats_previous = GameManager.player_stats.duplicate()
				GameManager.levels_unlocked+=1
			return  # Exit once the scene changes to avoid multiple checks
