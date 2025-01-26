extends Control

@onready var lvl1_button: Button = $MarginContainer/VBoxContainer/level_1
@onready var lvl2_button = $MarginContainer/VBoxContainer/level_2
@onready var lvl3_button = $MarginContainer/VBoxContainer/level_3
@onready var lvl4_button = $MarginContainer/VBoxContainer/level_4
@onready var lvl5_button = $MarginContainer/VBoxContainer/level_5

func _ready():
	lvl1_button.pressed.connect(_on_level_1_pressed)
	lvl2_button.pressed.connect(_on_level_2_pressed)
	lvl3_button.pressed.connect(_on_level_3_pressed)
	lvl4_button.pressed.connect(_on_level_4_pressed)
	lvl5_button.pressed.connect(_on_level_5_pressed)
	




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
		
func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	GameManager.current_scene_path = "res://scenes/main_menu.tscn"
