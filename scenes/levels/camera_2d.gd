extends Camera2D

@onready var health: Label = $health  # For Health
@onready var level: Label = $level  # For Level
@onready var coins: Label = $coins  # For Coins
@onready var gems: Label = $gems  # For Gems
@onready var score: Label = $score  # For Score
@onready var xp: Label = $xp  # For Xp

func _process(_delta: float) -> void:
	health.text = "Health: " + str(GameManager.player_stats["hp"]) + "/" + str(GameManager.player_stats_max["hp"])
	level.text = "Level: " + str(GameManager.player_stats["level"])
	coins.text = "Coins: " + str(GameManager.player_stats["coins"])
	gems.text = "Gems: " + str(GameManager.player_stats["gems"])
	score.text = "Score: " + str(GameManager.player_stats["score"])
	xp.text = "Xp: " + str(GameManager.player_stats["xp"])
