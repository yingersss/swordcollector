# this class is the reusable blueprint of an effect
# what it does
# what triggers it

#EffectResource (one per effect type)
#id: on_hit_burn
#kind/trigger: on_hit, on_equip, aura, etc.
#default params & bounds: e.g., chance default 0.1 (0–1), duration default 3.0 (0–10)
#logic hook: which script/class applies damage over time, spawns VFX, etc.
#stacking/dispell rules: e.g., does “burn” stack? refresh? cap?
#reusable across many items.

#example
#id: "on_hit_burn"
#kind: "on_hit"
#default_params: { chance: 0.10, damage_per_tick: 2, duration: 3.0 }
#bounds: { chance: [0,1], damage_per_tick: [1,10], duration: [0.5,10] }
#script: res://scripts/effects/burn.gd
#stacking: "refresh_duration"
#status_id: "status_burn"

# this would be the inventory_item
#id: "katana_flame"
#...
#effect_refs: [
#  { effect_id: "on_hit_burn",
#    params: { chance: 0.25, damage_per_tick: 3, duration: 4.0 } }
#]

#Equip item → read its EffectRefs.
#For each EffectRef: look up EffectResource by effect_id.
#Create a runtime EffectInstance using: (EffectResource logic) + (EffectRef params).
#Subscribe to the right trigger (on_hit) and apply the effect with those parameters.
#So: define behavior once in EffectResource, customize per item via EffectRef.

extends Resource

class_name EffectResource

@export var id: String
@export var kind: String #eg on hit, on equip, adjacent swords
@export var params := {} #default params values and bounds for validation
