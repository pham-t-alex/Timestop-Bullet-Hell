class_name SalvoData
extends Resource

@export var delay_after_fire: float
@export var shots: Array[Resource]

func _init():
	delay_after_fire = 0
	shots = []
