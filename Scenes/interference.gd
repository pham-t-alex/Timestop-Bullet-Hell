class_name Interference
extends Node2D

var interferedBullets: Dictionary

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	await get_tree().process_frame
	interfere()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func interfere() -> void:
	pass

func _on_area_entered(area: Area2D) -> void:
	interferedBullets[area] = null

func _on_area_exited(area: Area2D) -> void:
	interferedBullets.erase(area)
