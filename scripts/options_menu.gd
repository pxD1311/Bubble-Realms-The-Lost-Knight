extends Control

@onready var volume_button = $MarginContainer/VBoxContainer/volume
@onready var back_button = $MarginContainer/VBoxContainer/back

func _ready():
	volume_button.mouse_entered.connect(func() : volume_button.grab_focus())
	volume_button.focus_entered.connect(func(): volume_button.modulate = Color(1.2, 1.2, 1.2))
	volume_button.focus_exited.connect(func(): volume_button.modulate = Color.WHITE)
	# Connect buttons
	volume_button.pressed.connect(_on_volume_pressed)
	back_button.pressed.connect(_on_back_pressed)
	
	# Set initial focus
	volume_button.grab_focus()

func _on_volume_pressed():
	get_tree().change_scene_to_file("res://scenes/volume.tscn")


func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
