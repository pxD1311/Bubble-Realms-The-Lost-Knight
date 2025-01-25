extends Control


@onready var start_button = $VBoxContainer/Start
@onready var options_button = $VBoxContainer/Options
@onready var quit_button = $VBoxContainer/Quit

func _ready():
	# Connect buttons
	start_button.pressed.connect(_on_start_pressed)
	options_button.pressed.connect(_on_options_pressed)
	quit_button.pressed.connect(_on_quit_pressed)
	
	# Set initial focus
	start_button.grab_focus()

func _on_start_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/hub.tscn")

func _on_options_pressed():
	get_tree().change_scene_to_file("res://options_menu.tscn")

func _on_quit_pressed():
	get_tree().quit()
