extends Control



func _on_volume_pressed(volume_change: float):
	# Get the current master volume
	var current_volume = AudioServer.get_bus_volume_db(0)
	
	# Add the volume change (positive or negative)
	var new_volume = current_volume + volume_change
	
	# Clamp the volume to avoid exceeding limits (e.g., -80 dB to 0 dB)
	new_volume = clamp(new_volume, -80.0, 0.0)
	
	# Set the new master volume
	AudioServer.set_bus_volume_db(0, new_volume)
	
	# Print the new volume for debugging

	print("Master volume set to: ", new_volume, " dB")


func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
