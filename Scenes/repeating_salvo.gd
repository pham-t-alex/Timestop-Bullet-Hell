class_name RepeatingSalvo
extends Resource

@export var iterations: int
@export var salvos: Array[SalvoData]
@export var delay_after_iterations: float

func _init():
	iterations = 0
	salvos = []
	delay_after_iterations = 0
