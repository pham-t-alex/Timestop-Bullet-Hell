class_name SalvoData
extends Resource

@export var delay_after_fire: float
# RULE: DO NOT MIX BULLET_DATA AND SALVO_DATA
@export var shots: Array[Resource]
# Angle offset - usually 0
@export var angle_offset: float

func _init():
	delay_after_fire = 0
	shots = []
	angle_offset = 0

func copy():
	var salvo = SalvoData.new()
	salvo.delay_after_fire = delay_after_fire
	for shot in shots:
		salvo.shots.append(shot)
	salvo.angle_offset = angle_offset
	return salvo
