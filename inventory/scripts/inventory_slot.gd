extends Panel

class_name InventorySlot

@onready var icon: TextureRect = $CenterContainer/Panel/item_display
var item: ItemResource = null

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_STOP
	icon.mouse_filter = Control.MOUSE_FILTER_IGNORE
	icon.expand = true
	icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	update_ui()

func set_item(i: ItemResource) -> void:
	if item:
		if item.broken.is_connected(_on_item_broken):
			item.broken.disconnect(_on_item_broken)
		if item.durability_changed.is_connected(_on_durability_changed):
			item.durability_changed.disconnect(_on_durability_changed)
	item = i
	
	if item:
		if not item.broken.is_connected(_on_item_broken):
			item.broken.connect(_on_item_broken)
		if not item.durability_changed.is_connected(_on_durability_changed):
			item.durability_changed.connect(_on_durability_changed)
	update_ui()

func update(item_in: ItemResource) -> void:
	set_item(item_in)

func update_ui() -> void:
	if item == null:
		icon.texture = null
		icon.hide()
		tooltip_text = ""
	else:
		icon.texture = item.texture
		icon.show()
		tooltip_text = _format_tt()

func _get_drag_data(_at_position: Vector2) -> Variant:
	if item == null:
		return null
	var data := {
		"type": "slot_sword",
		"from": self,
		"item": item
	}
	# visible preview as just the icon
	var preview := TextureRect.new()
	preview.texture = icon.texture
	preview.expand = true
	preview.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	preview.set_custom_minimum_size(icon.size)
	set_drag_preview(preview)
	return data

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return typeof(data) == TYPE_DICTIONARY and data.get("type","") == "slot_sword"

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	var from_slot: Panel = data["from"]
	var incoming: ItemResource = data["item"]

	# swap items
	var tmp := item
	set_item(incoming)
	from_slot.set_item(tmp)
	
func _format_tt() -> String:
	return "%s\nAttack: %d\nDurability: %d/%d" % [
		item.display_name, item.attack, item.durability, item.max_durability
	]

func _on_item_broken() -> void:
	set_item(null)  # removes from inventory

func _on_durability_changed(_v:int) -> void:
	update_ui()
