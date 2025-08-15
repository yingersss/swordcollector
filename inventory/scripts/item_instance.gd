extends RefCounted

class_name ItemInstance

var resource: ItemResource
var current_durability: int

func _init(r: ItemResource) -> void: # constructor
	resource = r # takes the resource from item variable
	current_durability = r.durability # stores durability of resource

func is_broken() -> bool:
	return current_durability <= 0

# use once in battle: returns damage dealth this swing
func use_once() -> int:
	if is_broken():
		return 0 # later instead of returning 0, run something like r.break() and return resource.attack * 1.5
	current_durability -= 1
	return resource.attack

func repair(amount: int) -> void:
	current_durability = clamp(current_durability + amount, 0, resource.durability)
