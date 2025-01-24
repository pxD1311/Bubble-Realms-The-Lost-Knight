extends CharacterBody2D

# Movement parameters
@export var max_speed := 300.0
@export var acceleration := 2000.0
@export var friction := 2000.0
@export var jump_force := -600.0
@export var gravity := 1200.0

# Combat parameters
@export var melee_cooldown := 0.5
@export var ranged_cooldown := 0.8
var can_melee := true
var can_shoot := true

# Animation states
enum {IDLE, RUN, CROUCH, MELEE, RANGED}
var state := IDLE
var facing_right := true

@onready var animated_sprite := $AnimatedSprite2D
@onready var collision_stand := $CollisionStand
@onready var collision_crouch := $CollisionCrouch

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

#func shoot_projectile():
	#var projectile = preload("res://projectile.tscn").instantiate()
	#projectile.position = global_position
	#projectile.direction = Vector2.RIGHT if facing_right else Vector2.LEFT
	#get_parent().add_child(projectile)
