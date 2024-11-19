extends CharacterBody2D

@export var speed: float = 500.0
@export var maxHealth: int = 10
@export var health: int = 10

signal generate_bullet(pos: Vector2)

func _physics_process(delta) -> void:
	var direction := Input.get_vector("Left", "Right", "Up", "Down")
	velocity = direction * speed

	move_and_slide()

func shoot() -> void:
	generate_bullet.emit(position)

func take_damage(damage: int) -> void:
	health = max(0, health - damage)
	if (health == 0):
		queue_free()
