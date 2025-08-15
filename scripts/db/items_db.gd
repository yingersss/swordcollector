extends Node

class_name ItemsDB

var items: Dictionary = {} # id -> ItemResource

func _ready() -> void:
	# load all items from these folders
	for dir_path in ["res://inventory/swords/"]:
		_load_dir(dir_path)
	_validate_unique_ids()
	
func _load_dir(path: String) -> void:
	var dir := DirAccess.open(path)
	if dir == null:
		return
	dir.list_dir_begin()
	while true:
		var f := dir.get_next()
		if f == "":
			break
		if dir.current_is_dir():
			continue
		if f.ends_with(".tres") or f.ends_with(".res"):
			var res := load(path + "./" + f)
			if res is ItemResource and res.id != "":
				items[res.id] = res
	dir.list_dir_end()

func _validate_unique_ids() -> void:
	var seen := {}
	for id in items.keys():
		if seen.has(id):
			push_warning("Duplicate item ID: %s" % id)
		seen[id] = true

func make_instance(id: String) -> ItemInstance:
	var res: ItemResource = items.get(id)
	assert(res != null, "Unknown item ID: %s" % id)
	return ItemInstance.new(res)
