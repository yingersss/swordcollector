# Enemy.gd (resource)
extends Resource
class_name Enemy

signal health_changed(new_hp:int)
signal died

@export var name: String = "Enemy"
@export var texture: Texture2D
@export var max_health: int = 100

var _hp: int = 0
var current_health: int:
	get: return _hp
	set(v):
		var nv := clampi(v, 0, max_health)
		if nv == _hp: return
		_hp = nv
		health_changed.emit(_hp)
		if _hp == 0: died.emit()

func reset_health() -> void:
	current_health = max_health
