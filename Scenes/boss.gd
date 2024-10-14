extends CharacterBody2D

@export var action_set: Array[SalvoData]
var salvoStack: Array[SalvoData]
var salvoDelayStack: Array[int]

signal generate_bullet(pos: Vector2, data: BulletData)

func _ready() -> void:
	_generate_bullets_from_salvo(action_set[0])

func _generate_bullets_from_salvo(salvo: SalvoData) -> void:
	for data in salvo.shots:
		if data is SalvoData:
			_generate_bullets_from_salvo(data as SalvoData)
		else:
			var bullet_data := data as BulletData
			generate_bullet.emit(position, bullet_data)

func _on_bullet_delay_timeout() -> void:
	if salvoStack.is_empty():
		var rng := RandomNumberGenerator.new()
		var index := rng.randi_range(0, len(action_set) - 1)
		salvoStack.push_back(action_set[index])
	var salvo := salvoStack.pop_back() as SalvoData
	
	_generate_bullets_from_salvo(salvo as SalvoData)
