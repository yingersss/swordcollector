extends Control

@onready var inv: Inventory = preload("res://inventory/player_inv.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

# var is_open = false
var is_locked = false # when locked cannot move around items, this will only be locked when in combat

func _ready() -> void: # inventory is always visible
	update_slots()
	self.visible = true


func update_slots(): # call this when the inventory changes
	for i in range(min(inv.items.size(), slots.size())):
		slots[i].update(inv.items[i])

#func _process(_delta):
#	if Input.is_action_just_pressed("i"):
#		print("Toggling inventory")
#		if is_open:
#			close()
#		else:
#			open()

#func open() -> void:
#	self.visible = true
#	is_open = true

#func close() -> void:
#	visible = false
#	is_open = false
