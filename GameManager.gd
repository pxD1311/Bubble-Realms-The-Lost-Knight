extends Node

enum GameState { MENU, PLAYING, PAUSED, GAME_OVER }
var current_state = GameState.MENU
var autosave_timer = 0.0
var autosave_interval = 60.0  # Autosave every 60 seconds

var player_stats = {"hp": 100, "attack": 10, "xp": 0, "level": 1, "score" : 0}

func _ready():
<<<<<<< HEAD
	# Set initial state or load saved game data if needed
	load_scene("res://scenes/level_1.tscn")
	#load_main_menu()
=======
	# Set the initial state or load saved game data
	call_deferred("load_scene", "res://scenes/levels/level_2.tscn")
	# Optionally load a main menu instead
	# load_main_menu()
>>>>>>> 0cabebc414c25e5ea510ce6c7913604a03feaf95

func _process(delta):
	if current_state == GameState.PLAYING:
		autosave_timer += delta
		if autosave_timer >= autosave_interval:
			save_game()
			autosave_timer = 0

func _input(event):
	if event.is_action_pressed("pause"):
		if current_state == GameState.PLAYING:
			pause_game()
		elif current_state == GameState.PAUSED:
			resume_game()

func start_game():
	current_state = GameState.PLAYING
	load_main_menu()

func game_over():
	current_state = GameState.GAME_OVER
	load_scene("res://scenes/game_over_scene.tscn")

func pause_game():
	current_state = GameState.PAUSED
	get_tree().paused = true

func resume_game():
	current_state = GameState.PLAYING
	get_tree().paused = false

func load_hub():
	load_scene("res://scenes/hub.tscn")

func load_main_menu():
	load_scene("res://scenes/main_menu.tscn")

func load_scene(scene_path):
	if ResourceLoader.exists(scene_path):
		get_tree().change_scene_to_file(scene_path)
	else:
		print("Scene path does not exist: ", scene_path)


func save_game():
	var save_data = {"player_stats": player_stats, "current_state": current_state}
	var file = FileAccess.open("user://save_game.dat", FileAccess.WRITE)
	if file:
		file.store_var(save_data)
		file.close()
		print("Game saved successfully.")
	else:
		print("Failed to save game.")

func load_game():
	if FileAccess.file_exists("user://save_game.dat"):
		var file = FileAccess.open("user://save_game.dat", FileAccess.READ)
		if file:
			var save_data = file.get_var()
			file.close()
			if save_data.has("player_stats") and save_data.has("current_state"):
				player_stats = save_data["player_stats"]
				current_state = save_data["current_state"]
				print("Game loaded successfully.")
			else:
				print("Save file is corrupted. Loading defaults.")
		else:
			print("Failed to open save file.")
	else:
		print("Save file not found. Starting a new game.")

func update_ui():
	if $HUD/ScoreLabel:
		$HUD/ScoreLabel.text = "Score: " + str(player_stats["player_score"])
	if $HUD/HPLabel:
		$HUD/HPLabel.text = "HP: " + str(player_stats["hp"])

# Example function for achievements (can be extended later)
func unlock_achievement(achievement_name):
	print("Achievement unlocked: ", achievement_name)
