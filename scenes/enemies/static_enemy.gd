extends Area2D

signal enemy_died(xp_reward)
@export var max_health := 40
@export var damage_per_second := 15
@export var xp_reward := 10

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@onready var damage_timer = $Damage_timer


var current_health : int

@export var flip: bool

func _ready():
	if flip:
		animated_sprite_2d.flip_h = true
	add_to_group("enemies")
	current_health = max_health
	# Configure damage timer
	damage_timer.wait_time = 1.0  # Damage every second
	damage_timer.start()

func take_damage(amount):
	current_health -= amount
	print("Enemy took ", amount, " damage. Remaining HP: ", current_health)
	
	if current_health <= 0:
		die()

func die():
	# Reward XP to player
	print("Enemy died.")
	var game_manager = get_node("/root/GameManager")
	game_manager.add_xp(5)
	queue_free()

func _on_body_entered(body):
	if body.is_in_group("player"):
		# Initial damage on contact
		body.take_damage(damage_per_second)

func _on_timer_timeout():
	# Periodic damage while player remains in area
	for body in get_overlapping_bodies():
		if body.is_in_group("player"):
			body.take_damage(damage_per_second)

func _on_area_entered(area):
	# Detect player attacks (if using area-based attacks)
	if area.is_in_group("player_attack"):
		take_damage(area.damage)


func _on_damage_timer_timeout() -> void:
	for body in get_overlapping_bodies():
		if body.is_in_group("player"):
			body.take_damage(damage_per_second)
