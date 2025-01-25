# WaterBlast.gd
extends Area2D

@export var speed := 400.0
@export var damage := 20
var direction := Vector2.RIGHT

func _ready():
	$AnimatedSprite2D.flip_h = direction.x < 0
	$AnimatedSprite2D.play("start")  # Basic water animation
	$Timer.start(3.0)  # Auto-delete after 2 seconds

func _physics_process(delta):
	position += direction * 0.5 * speed * delta

#func _on_body_entered(body):
	#if body.has_method("take_damage"):
		#body.take_damage(damage)
	#queue_free()

func _on_timer_timeout():
	queue_free()
