extends Area2D

var damage: int
var velocity: Vector2
var relative_accel: Vector2
var absolute_accel: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func initialize(damage: int, angle: float, velocity: float, relative_accel: Vector2, absolute_accel: Vector2) -> void:
	self.damage = damage
	self.velocity = Vector2.DOWN.rotated(deg_to_rad(angle)) * velocity
	self.relative_accel = relative_accel
	self.absolute_accel = absolute_accel
	rotate(deg_to_rad(angle - 90))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	position += velocity * delta
	velocity += relative_accel.rotated(velocity.angle()) * delta
	velocity += absolute_accel * delta
