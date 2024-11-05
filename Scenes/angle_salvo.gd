class_name AngleSalvo
extends Resource

@export var delay_after_shot: float
# either bullet or salvo
@export var shot: Resource
# start and end are both inclusive
@export var start_angle: float
@export var end_angle: float
@export var step: float
@export var final_delay: float

func _init():
	delay_after_shot = 0
	shot = null
	start_angle = 0
	end_angle = 0
	step = 0
	final_delay = 0
