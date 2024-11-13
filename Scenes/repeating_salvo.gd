class_name RepeatingSalvo
extends Resource

@export var iterations: int
@export var salvos: Array[Resource]
@export var final_delay: float

func _init():
	iterations = 0
	salvos = []
	final_delay = 0
