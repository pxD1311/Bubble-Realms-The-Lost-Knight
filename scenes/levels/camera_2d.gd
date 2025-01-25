extends Camera2D

@onready var label1: Label = $Label1  # For Health
@onready var label2: Label = $Label2  # For Level
@onready var label3: Label = $Label3  # For Coins
@onready var label4: Label = $Label4  # For Gems
@onready var label5: Label = $Label5  # For Score

func _process(delta: float) -> void:
	label1.text = "Health: " + str(GameManager.player_stats["hp"]) + "/" + str(GameManager.player_stats_max["hp"])
	label2.text = "Level: " + str(GameManager.player_stats["level"])
	label3.text = "Coins: " + str(GameManager.player_stats["coins"])
	label4.text = "Gems: " + str(GameManager.player_stats["gems"])
	label5.text = "Score: " + str(GameManager.player_stats["score"])
