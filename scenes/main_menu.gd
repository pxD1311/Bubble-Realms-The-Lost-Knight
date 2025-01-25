extends Control

@onready var start_button: Button = $VBoxContainer/Start
@onready var options_button = $VBoxContainer/Options
@onready var quit_button = $VBoxContainer/Quit

func _ready():
	start_button.mouse_entered.connect(func() : start_button.grab_focus())
	start_button.focus_entered.connect(func(): start_button.modulate = Color(1.2, 1.2, 1.2))
	start_button.focus_exited.connect(func(): start_button.modulate = Color.WHITE)
	# Connect buttons
	start_button.pressed.connect(_on_start_pressed)
	options_button.pressed.connect(_on_options_pressed)
	quit_button.pressed.connect(_on_quit_pressed)
	
	# Set initial focus
	start_button.grab_focus()

func _on_start_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/hub.tscn")
	GameManager.current_scene_path = "res://scenes/levels/hub.tscn"

func _on_options_pressed():
	get_tree().change_scene_to_file("res://options_menu.tscn")

func _on_quit_pressed():
	get_tree().quit()
