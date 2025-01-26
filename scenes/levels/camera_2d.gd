extends Camera2D

@onready var level: Label = $VBoxContainer/level
@onready var health: Label = $VBoxContainer/health
@onready var xp: Label = $VBoxContainer2/xp
@onready var score: Label = $VBoxContainer2/score
@onready var coins: Label = $VBoxContainer3/coins
@onready var gems: Label = $VBoxContainer3/gems


func _process(_delta: float) -> void:
	health.text = "Health: " + str(GameManager.player_stats["hp"]) + "/" + str(GameManager.player_stats_max["hp"])
	level.text = "Level: " + str(GameManager.player_stats["level"])
	coins.text = "Coins: " + str(GameManager.player_stats["coins"])
	gems.text = "Gems: " + str(GameManager.player_stats["gems"])
	score.text = "Score: " + str(GameManager.player_stats["score"])
	xp.text = "Xp: " + str(GameManager.player_stats["xp"])
