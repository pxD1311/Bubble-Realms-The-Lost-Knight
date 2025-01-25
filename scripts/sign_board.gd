extends Area2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var label: Label = $VBoxContainer/Label


@export var text: String


func _ready():
	label.text = text
	label.visible = false


func _process(delta: float) -> void:
	# Check for overlapping bodies
	var overlapping_bodies = get_overlapping_bodies()
	
	for body in overlapping_bodies:
		if body is CharacterBody2D:
			label.visible = true
		else:
			label.visible = false
