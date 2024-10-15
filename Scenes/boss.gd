extends CharacterBody2D

@export var action_set: Array[SalvoData]
var currently_executing_salvo := false

signal generate_bullet(pos: Vector2, data: BulletData)
signal completed_action

func _ready() -> void:
	take_action()

func _generate_bullets_from_salvo(salvo: SalvoData, topLevel: bool) -> void:
	for data in salvo.shots:
		if data is SalvoData:
			_generate_bullets_from_salvo(data as SalvoData, false)
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
