extends Control

@onready var back_button: Button = $VBoxContainer/back
# Called when the node enters the scene tree for the first time.
func _ready():
	back_button.mouse_entered.connect(func() : back_button.grab_focus())
	back_button.focus_entered.connect(func(): back_button.modulate = Color(1.2, 1.2, 1.2))
	back_button.focus_exited.connect(func(): back_button.modulate = Color.WHITE)
	
	back_button.pressed.connect(_on_back_pressed)
	
	back_button.grab_focus()

func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/options_menu.tscn")
