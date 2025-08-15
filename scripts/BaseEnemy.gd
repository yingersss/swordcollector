extends Resource

class_name Enemy

signal health_changed(new_hp: int)
signal died

@export var name = "Enemy"
@export var texture: Texture2D
@export var max_health: int
@export var inventory: Inventory

var _hp : int = max_health

var current_health: int:
	get: return _hp
	set(value):
		var v := clampi(value, 0, max_health)
		if v == _hp:
			return
		_hp = v
		health_changed.emit(_hp)
		if _hp == 0:
			died.emit()

func reset_health() -> void:
	current_health = max_health

func apply_damage(dmg: int) -> void:
	current_health -= max(dmg, 0)

func heal(amount: int) -> void:
	current_health += max(amount, 0)
