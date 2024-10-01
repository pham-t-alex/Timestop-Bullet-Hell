class_name BulletData
extends Resource

# angle represents the angle relative to
# down direction from boss
# e.g. angle=90 represents rightward direction
@export var angle: float
# the starting velocity of the bullet
@export var velocity: float
# constant acceleration relative to direction
# of motion; can be used to curve the
# bullet
# x will be accel in direction of motion,
# y will be accel in direction tangent to 
# direction of motion (angle + 90 degrees
# counterclockwise)
@export var relative_accel: Vector2
# constant acceleration (not relative to
# direction of motion, just constant)
@export var absolute_accel: Vector2

func _init():
	angle = 0
	velocity = 0
	relative_accel = Vector2.ZERO
	absolute_accel = Vector2.ZERO
