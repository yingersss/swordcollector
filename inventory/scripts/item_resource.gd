extends Resource
class_name ItemResource

signal durability_changed(new_val:int)
signal broken

@export var id: String
@export var display_name: String = ""
@export var texture: Texture2D
@export var attack: int = 5

@export var max_durability: int = 20 : set = _set_max_durability

var _durability: int = 0
var durability: int:
	get: return _durability
	set(v):
		var nv := clampi(v, 0, max_durability)
		if nv == _durability: return
		_durability = nv
		durability_changed.emit(_durability)
		if _durability == 0:
			broken.emit()

func _set_max_durability(v: int) -> void:
	max_durability = max(1, v)
	# Initialize to full the first time (or clamp if max lowered).
	_durability = max_durability if (_durability == 0) else min(_durability, max_durability)

func use_once() -> void:
	durability -= 1
