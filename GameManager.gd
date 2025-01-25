extends Node

# Enum for game states
enum GameState { MENU, PLAYING, PAUSED, GAME_OVER }
var current_state = GameState.MENU

# Autosave variables
var autosave_timer = 0.0
var autosave_interval = 60.0  # Autosave every 60 seconds

# Player stats
var player_stats = {"hp": 100, "attack": 10, "xp": 0, "level": 1, "score": 0, "gems" : 0, "coins" : 0}

var levels_unlocked : int = 3
# Store the current scene path for restarting
var current_scene_path = ""

func _ready():
	# Set the initial state or load saved game data
	call_deferred("load_scene", "res://scenes/levels/level_1.tscn")
	# Optionally load a main menu instead
	# load_main_menu()

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

# Game state management
func start_game():
	current_state = GameState.PLAYING
	load_main_menu()

func game_over():
	current_state = GameState.GAME_OVER
	load_scene(current_scene_path)

func pause_game():
	current_state = GameState.PAUSED
	get_tree().paused = true

func resume_game():
	current_state = GameState.PLAYING
	get_tree().paused = false

# Scene loading
func load_main_menu():
	load_scene("res://scenes/main_menu.tscn")
#Hub
func load_hub():
	load_scene("res://scenes/levels/hub.tscn")

func load_scene(scene_path):
	if ResourceLoader.exists(scene_path):
		current_scene_path = scene_path  # Store the scene path
		get_tree().change_scene_to_file(scene_path)
	else:
		print("Scene path does not exist: ", scene_path)

func restart_scene():
	Engine.time_scale = 1  # Reset the time scale
	if current_scene_path != "":
		load_scene(current_scene_path)
	else:
		print("No scene path to restart!")

# Save and load game
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

# UI updates
func update_ui():
	if $HUD/ScoreLabel:
		$HUD/ScoreLabel.text = "Score: " + str(player_stats["score"])
	if $HUD/HPLabel:
		$HUD/HPLabel.text = "HP: " + str(player_stats["hp"])

# KillZone handling
func handle_kill_zone(body):
	if body.name == "Character":  # Adjust based on your player node's name
		print("KillZone: Player entered")
		current_state = GameState.GAME_OVER  # Change game state
		player_stats["hp"] = 0  # Update player stats (optional)
		Engine.time_scale = 0.5  # Slow down the game for effect

		# Restart the scene after a short delay
		get_tree().create_timer(0.5).timeout.connect(restart_scene)

func add_gem():
	player_stats["gems"]+=1
	player_stats["score"]+=20
	print(player_stats)
	
func add_coin():
	player_stats["coins"]+=1
	player_stats["score"]+=10
	print(player_stats)
	
func add_xp(amount: int):
	player_stats["xp"] += amount
	print("Player XP: ", player_stats["xp"])
	
