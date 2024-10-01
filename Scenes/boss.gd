extends CharacterBody2D

@export var action_set: Array[SalvoData]

func _shoot() -> void:
	var rng := RandomNumberGenerator.new()
	var index := rng.randi_range(0, len(action_set) - 1)
	var salvo := action_set[index]
	_generate_bullets_from_salvo(salvo as SalvoData)
	
func _generate_bullets_from_salvo(salvo: SalvoData) -> void:
	for data in salvo.shots:
		if data is SalvoData:
			_generate_bullets_from_salvo(data as SalvoData)
		else:
			var bullet_data := data as BulletData
			# generate bullet from bulletdata
