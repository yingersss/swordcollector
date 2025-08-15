extends TextureRect

class_name EnemyView

@export var enemy : Enemy

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return typeof(data) == TYPE_DICTIONARY and data.get("type") == "slot_sword"

func _drop_data(_pos: Vector2, data: Variant) -> void:
	var sword: ItemResource = data["item"]
	if sword and enemy:
		enemy.current_health -= sword.attack
		print("%s took %d damage! HP now %d" % [enemy.name, sword.attack, enemy.current_health])
