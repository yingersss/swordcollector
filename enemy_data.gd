extends TextureRect

class_name EnemyView

@export var enemy : Enemy
@onready var hp_bar: ProgressBar = $"../ProgressBar"
@onready var hp_label : Label = $"../ProgressBar/Label"

func _ready() -> void:
	if enemy == null:
		return

	enemy.reset_health()            # <-- ensure full HP at start
	texture = enemy.texture
	
	# init hp ui
	hp_bar.min_value = 0
	hp_bar.max_value = enemy.max_health
	hp_bar.value = enemy.current_health
	hp_label.text = "%d / %d" % [enemy.current_health, enemy.max_health]
	
	# keep UI in sync
	enemy.health_changed.connect(_on_hp_changed)

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return typeof(data) == TYPE_DICTIONARY and data.get("type") == "slot_sword"

func _drop_data(_pos: Vector2, data: Variant) -> void:
	var sword: ItemResource = data["item"]
	if sword and enemy:
		enemy.current_health -= sword.attack
		print("%s took %d damage! HP now %d" % [enemy.name, sword.attack, enemy.current_health])

func _on_hp_changed(new_hp:int) -> void:
	hp_bar.value = new_hp
	hp_label.text = "%d / %d" % [new_hp, enemy.max_health]
