extends AnimatableBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D

@export var position_sprite_x: float
@export var position_sprite_y: float
@export var start_angle_degrees: float = 0.0    # Starting angle of the arc (in degrees)
@export var end_angle_degrees: float = 90.0     # Ending angle of the arc (in degrees)
@export var revolution_radius: float = 100.0    # Distance from the center
@export var revolution_speed_degrees: float = 90.0 # Speed of revolution (degrees per second)

var current_angle_degrees: float # Track the current angle in degrees
var angle_direction: int = -1    # -1 for counterclockwise, 1 for clockwise

func _ready() -> void:
	# Set the initial angle to the starting angle
	current_angle_degrees = start_angle_degrees
	# Move the sprite to its initial position
	var start_radians = deg_to_rad(current_angle_degrees)
	sprite_2d.position = Vector2(
		cos(start_radians), 
		sin(start_radians)
	) * revolution_radius + Vector2(position_sprite_x, position_sprite_y)

func _process(delta: float) -> void:
	# Update the current angle based on direction
	current_angle_degrees += revolution_speed_degrees * delta * angle_direction

	# Restrict the angle within the range [start_angle_degrees, end_angle_degrees]
	if current_angle_degrees > end_angle_degrees:
		current_angle_degrees = end_angle_degrees
		angle_direction = -1 # Reverse to counterclockwise
	elif current_angle_degrees < start_angle_degrees:
		current_angle_degrees = start_angle_degrees
		angle_direction = 1 # Reverse to clockwise

	# Convert the current angle to radians for calculations
	var current_radians = deg_to_rad(current_angle_degrees)

	# Calculate the new position along the arc
	var offset = Vector2(
		cos(current_radians), 
		sin(current_radians)
	) * revolution_radius

	# Update the sprite's position relative to its parent's position
	sprite_2d.position = offset + Vector2(position_sprite_x, position_sprite_y)
