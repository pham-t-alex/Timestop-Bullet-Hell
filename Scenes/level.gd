extends Node2D

const BULLET_SCENE = preload("res://Scenes/bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_boss_generate_bullet(pos: Vector2, data: BulletData) -> void:
	var bullet := BULLET_SCENE.instantiate()
	$BossBullets.add_child(bullet)
	bullet.position = pos
	bullet.initialize(0, data.angle, data.velocity, data.relative_accel, data.absolute_accel)
