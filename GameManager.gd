extends Node

# Define game states
enum GameState {
	MAIN_MENU,
	PLAYING,
	PAUSED,
	GAME_OVER
}

# Current game state
var current_state : GameState = GameState.MAIN_MENU

# Nodes to manage
var player : Node = null
var score : int = 0
var ui : Node = null

func _ready():
	# Initialization of the game (for example, linking nodes)
	player = get_node("Player")
	ui = get_node("UI")
	show_main_menu()

func _process(delta):
	match current_state:
		GameState.PLAYING:
			_handle_playing(delta)
		GameState.PAUSED:
			_handle_paused()  # This line calls the _handle_paused function
		GameState.GAME_OVER:
			_handle_game_over()

# Main menu
func show_main_menu():
	current_state = GameState.MAIN_MENU
	ui.show_main_menu()
	# Additional logic for showing main menu UI

func start_game():
	current_state = GameState.PLAYING
	score = 0
	player.start_game()
	ui.update_score(score)
	# Additional setup for starting the game

# Gameplay state
func _handle_playing(delta):
	# Game logic, like updating score, controlling player, etc.
	player.move(delta)
	if player.collides_with_obstacle():
		end_game()
	# You can also add time-based events, AI behavior, etc.

# Pause functionality
func pause_game():
	current_state = GameState.PAUSED
	ui.show_pause_menu()

func resume_game():
	current_state = GameState.PLAYING
	ui.hide_pause_menu()

# Handle the paused state
func _handle_paused():
	# When the game is paused, listen for user input to resume or quit
	if Input.is_action_just_pressed("ui_accept"):  # or use another action like "ui_cancel"
		resume_game()

# Game over state
func end_game():
	current_state = GameState.GAME_OVER
	ui.show_game_over()
	# Show the final score, restart options, etc.

# Handling the game over state
func _handle_game_over():
	# Wait for player input to restart or quit the game
	if Input.is_action_just_pressed("ui_accept"):
		restart_game()

# Restart the game
func restart_game():
	current_state = GameState.MAIN_MENU
	ui.hide_game_over()
	show_main_menu()
