extends CharacterBody2D

@export var action_set: Array[Resource]
var currently_executing_salvo := false

signal generate_bullet(pos: Vector2, rotation: float, data: BulletData)
signal completed_action

func _ready() -> void:
	compile_salvos()
	take_action()

func _generate_bullets_from_salvo(salvo: SalvoData, rotation: float, topLevel: bool) -> void:
	for data in salvo.shots:
		if data is SalvoData:
			await _generate_bullets_from_salvo(data as SalvoData, rotation + salvo.angle_offset, false)
		else:
			var bullet_data := data as BulletData
			generate_bullet.emit(position, rotation + salvo.angle_offset, bullet_data)
	if (salvo.delay_after_fire > 0):
		$SalvoDelay.start(salvo.delay_after_fire)
		await $SalvoDelay.timeout
	if topLevel:
		completed_action.emit()

func take_action() -> void:
	var rng := RandomNumberGenerator.new()
	var index := rng.randi_range(0, len(action_set) - 1)
	currently_executing_salvo = true
	var salvo := action_set[index]
	_generate_bullets_from_salvo(salvo as SalvoData, 0, true)

func compile_salvos() -> void:
	for i in range(0, len(action_set)):
		action_set[i] = compile_recurse(action_set[i])

func compile_recurse(r: Resource) -> SalvoData:
	if (r is SalvoData):
		return (r as SalvoData).copy()
	if (r is AngleSalvo):
		var a = r as AngleSalvo
		var s = SalvoData.new()
		s.delay_after_fire = a.final_delay
		var angle = a.start_angle
		var shot = a.shot
		if (shot is BulletData):
			while (angle <= a.end_angle):
				var bullet = (shot as BulletData).copy()
				bullet.angle += angle
				s.shots.append(bullet)
				angle += a.step
		else:
			while (angle <= a.end_angle):
				var salvo = compile_recurse(shot)
				salvo.delay_after_fire += a.delay_after_shot
				salvo.angle_offset += angle
				s.shots.append(salvo)
				angle += a.step
		return s
	elif (r is RepeatingSalvo):
		var repeat = r as RepeatingSalvo
		var s = SalvoData.new()
		s.delay_after_fire = repeat.final_delay
		var salvos = []
		for salvo in repeat.salvos:
			salvos.append(compile_recurse(salvo))
		for i in range(0, repeat.iterations):
			for salvo in salvos:
				s.shots.append(salvo)
		return s
	return null
