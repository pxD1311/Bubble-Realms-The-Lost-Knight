extends CharacterBody2D

# Movement parameters
@export var max_speed := 300.0
@export var acceleration := 2000.0
@export var friction := 2000.0
@export var jump_force := -600.0
@export var gravity := 1200.0

# Combat parameters
@export var melee_cooldown := 1.0
@export var ranged_cooldown := 1.0
var can_melee := true
var can_shoot := true

# Animation states
enum {IDLE, RUN, CROUCH, MELEE, RANGED}
var state := IDLE
var facing_right := true

@onready var animated_sprite := $AnimatedSprite2D2
@onready var collision_stand := $CollisionStand2
@onready var collision_crouch := $CollisionCrouch2

	
func _physics_process(delta):
	handle_movement(delta)
	handle_attacks()
	update_animation()
	apply_gravity(delta)
	move_and_slide()

func handle_movement(delta):
	var input_dir = Input.get_axis("move_left", "move_right")
	
	# Horizontal movement
	if input_dir != 0:
		velocity.x = move_toward(velocity.x, input_dir * max_speed, acceleration * delta)
		facing_right = input_dir > 0
	else:
		velocity.x = move_toward(velocity.x, 0, friction * delta)
	
	# Crouching
	if Input.is_action_pressed("crouch") and is_on_floor():
		state = CROUCH
		collision_stand.disabled = true
		collision_crouch.disabled = false
	else:
		collision_stand.disabled = false
		collision_crouch.disabled = true

func handle_attacks():
	if Input.is_action_just_pressed("melee") and can_melee:
		state = MELEE
		can_melee = false
		await get_tree().create_timer(melee_cooldown).timeout
		can_melee = true
		state = IDLE
	
	#if Input.is_action_just_pressed("ranged_attack") and can_shoot:
		#state = RANGED
		#can_shoot = false
		#shoot_projectile()
		#await get_tree().create_timer(ranged_cooldown).timeout
		#can_shoot = true
		#state = IDLE

func update_animation():
	animated_sprite.flip_h = !facing_right
	
	match state:
		MELEE:
			animated_sprite.play("melee_attack")
		RANGED:
			animated_sprite.play("ranged_attack")
		CROUCH:
			animated_sprite.play("crouch")
		_:
			if abs(velocity.x) > 10:
				animated_sprite.play("run")
			else:
				animated_sprite.play("idle")

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

func gain_xp(amount):
	GameManager.player_stats["xp"] += amount
	if GameManager.player_stats["xp"] >= xp_to_next_level():
		level_up()

func xp_to_next_level():
	return GameManager.player_stats["level"] * 100  # Example formula

func level_up():
	GameManager.player_stats["level"] += 1
	GameManager.player_stats["attack"] += 5
	GameManager.player_stats["hp"] += 20
	print("Leveled up! Current level: ", GameManager.player_stats["level"])

func increase_attack(amount):
	GameManager.player_stats["attack"] += amount
	print("Attack increased by ", amount, ". Current attack: ", GameManager.player_stats["attack"])

func deal_damage_to_enemy(enemy_hp, critical_hit_chance = 0.1):
	var damage = GameManager.player_stats["attack"]
	if randf() < critical_hit_chance:  # 10% chance for a critical hit
		damage *= 2
		print("Critical hit!")
	enemy_hp -= damage
	print("Dealt ", damage, " damage. Enemy HP left: ", enemy_hp)
	return enemy_hp  # Return remaining enemy HP

func take_damage(amount):
	GameManager.player_stats["hp"] -= amount
	if GameManager.player_stats["hp"] <= 0:
		GameManager.player_stats["hp"] = 0
		animated_sprite.play("dying")
		GameManager.game_over()
	else:
		print("Player took ", amount, " damage. HP: ", GameManager.player_stats["hp"])

func heal_player(amount, max_hp = 200):
	GameManager.player_stats["hp"] += amount
	if GameManager.player_stats["hp"] > max_hp:
		GameManager.player_stats["hp"] = max_hp
	print("Player healed by ", amount, ". HP: ", GameManager.player_stats["hp"])

func revive_player(revive_hp = 50):
	if GameManager.player_stats["hp"] == 0:
		GameManager.player_stats["hp"] = revive_hp
		print("Player revived! HP: ", GameManager.player_stats["hp"])
	else:
		print("Player is not dead. Revival skipped.")

func increase_score(points):
	GameManager.player_score += points
	print("Score increased by ", points, ". Current score: ", GameManager.player_score)

func decrease_score(points):
	GameManager.player_score -= points
	if GameManager.player_score < 0:
		GameManager.player_score = 0
	print("Score decreased by ", points, ". Current score: ", GameManager.player_score)

func reset_score():
	GameManager.player_score = 0
	print("Score reset. Current score: ", GameManager.player_score)

func is_player_dead():
	return GameManager.player_stats["hp"] <= 0
	
func get_player_stats():
	print("Player Stats: ", GameManager.player_stats)
	return GameManager.player_stats

#func shoot_projectile():
	#var projectile = preload("res://projectile.tscn").instantiate()
	#projectile.position = global_position
	#projectile.direction = Vector2.RIGHT if facing_right else Vector2.LEFT
	#get_parent().add_child(projectile)
