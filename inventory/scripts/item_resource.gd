extends Resource
class_name ItemResource

signal durability_changed(new_val:int)
signal broken

@export var id: String                     # "sword_iron"
@export var display_name: String = ""      # "Iron Sword"
@export var texture: Texture2D                # inventory icon (optional for now)


@export var attack: int
@export var max_durability: int
var durability := max_durability

func use_once() -> void:
	durability = max(durability -1, 0)
	durability_changed.emit(durability)
	if durability == 0:
		broken.emit()
