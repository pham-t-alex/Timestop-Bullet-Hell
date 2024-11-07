extends CharacterBody2D

@export var action_set: Array[Resource]
var currently_executing_salvo := false

signal generate_bullet(pos: Vector2, data: BulletData)
signal completed_action

func _ready() -> void:
	take_action()

func _generate_bullets_from_salvo(salvo: SalvoData, topLevel: bool) -> void:
	for data in salvo.shots:
		if data is SalvoData:
			await _generate_bullets_from_salvo(data as SalvoData, false)
		else:
			var bullet_data := data as BulletData
			generate_bullet.emit(position, bullet_data)
	$SalvoDelay.start(salvo.delay_after_fire)
	await $SalvoDelay.timeout
	if topLevel:
		completed_action.emit()

func take_action() -> void:
	var rng := RandomNumberGenerator.new()
	var index := rng.randi_range(0, len(action_set) - 1)
	currently_executing_salvo = true
	var salvo := action_set[index]
	_generate_bullets_from_salvo(salvo as SalvoData, true)

func compile_salvos() -> void:
	for i in range(0, len(action_set)):
		action_set[i] = compile_recurse(action_set[i])

func compile_recurse(r: Resource) -> SalvoData:
	if (r is SalvoData):
		return r as SalvoData
	if (r is AngleSalvo):
		var a = r as AngleSalvo
		
	elif (r is RepeatingSalvo):
		var repeat = r as RepeatingSalvo
		var s = SalvoData.new()
		s.delay_after_fire = repeat.delay_after_iterations
		for i in range(0, repeat.iterations):
			for salvo in repeat.salvos:
				compile_recurse(salvo)
	return null
