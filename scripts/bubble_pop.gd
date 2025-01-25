extends StaticBody2D

@onready var area_2d = $Area2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var collision_shape_2d = $CollisionShape2D

var is_inside_area: bool = false
var inside_time: float = 0.0
var outside_time: float = 0.0

var has_entered: bool = false

var time_threshold: float = 2.0  # Time threshold for 2 seconds inside or outside

func _ready():
	inside_time = 0.0
	outside_time = 0.0

func _process(delta):
	# Check if the Area2D is currently overlapping with another body
	var overlapping_bodies = area_2d.get_overlapping_bodies()

	if overlapping_bodies.size() > 0:
		# If inside the area, increment inside time
		if not is_inside_area:
			is_inside_area = true
			inside_time = 0.0  # Reset inside time when entering
			print("Entered the area")

		inside_time += delta  # Increment the inside time by the delta time
		print(inside_time)
		# If the inside time has exceeded the threshold, trigger "pop"
		if inside_time >= time_threshold:
			_on_area_2d_area_entered()  # Call the area entered logic

	else:
		# If outside the area, increment outside time
		if is_inside_area:
			is_inside_area = false
			outside_time = 0.0  # Reset outside time when exiting
			print("Exited the area")

		outside_time += delta  # Increment the outside time by the delta time

		# If the outside time has exceeded the threshold, trigger "create"
		if outside_time >= time_threshold:
			_on_area_2d_area_exited()  # Call the area exited logic

func _on_area_2d_area_entered():
	has_entered = true
	animated_sprite_2d.play("pop")
	collision_shape_2d.disabled = true

func _on_area_2d_area_exited():
	if has_entered:
		has_entered = false
		animated_sprite_2d.play("create")
		collision_shape_2d.disabled = false
