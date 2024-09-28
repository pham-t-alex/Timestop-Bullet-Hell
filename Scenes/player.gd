extends CharacterBody2D

@export var speed: float = 500.0

func _physics_process(delta) -> void:
	
	var direction := Input.get_vector("Left", "Right", "Up", "Down")
	velocity = direction * speed

	move_and_slide()
