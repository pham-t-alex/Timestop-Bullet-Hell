extends Interference

var frozenBullets := []
@export var time := 3

func interfere() -> void:
	for area in interferedBullets:
		frozenBullets.append(area)
		(area as Bullet).frozen = true
	
	var t = Timer.new()
	add_child(t)
	t.start(time)
	await t.timeout
	
	for area in frozenBullets:
		if (is_instance_valid(area)):
			(area as Bullet).frozen = false
	
	queue_free()
