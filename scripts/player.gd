extends Control
class_name Player

@export var data: PlayerData

signal health_changed(current: int, maxv: int)

func _ready() -> void:
	_emit_health()

func take_damage(amount: int) -> void:
	if data == null:
		return
	data.apply_damage(amount)
	_emit_health()

func _emit_health() -> void:
	emit_signal("health_changed", data.current_health, data.max_health)
