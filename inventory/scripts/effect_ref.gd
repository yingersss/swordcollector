# a reference + per-item overrides
# what blueprints to use, and the exact parameter values this item wants

extends Resource

class_name EffectRef

@export var effect_id:String
@export var params := {} # dictionary of static params
