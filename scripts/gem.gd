extends Area2D

@export var score_value := 10  # Adjust in inspector for different coins
@export var pickup_sound : AudioStream

func _ready():
	# Connect the collision signal automatically
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("player"):
		collect(body)

func collect(player):
	# Add score through GameManager or directly to player
	GameManager.add_gem()
	
	# Play pickup sound if available
	if $coin_sound.stream != null:
		$coin_sound.play()
		await $coin_sound.finished
	
	queue_free()  # Remove coin after collection
