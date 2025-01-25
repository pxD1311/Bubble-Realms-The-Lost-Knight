extends Area2D

@onready var label: Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# Check for overlapping bodies
	var overlapping_bodies = get_overlapping_bodies()
	
	for body in overlapping_bodies:
		if body is CharacterBody2D:
			label.visible = true
		else:
			label.visible = false
