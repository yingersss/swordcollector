extends Resource
class_name ItemResource

@export var id: String                     # "sword_iron"
@export var display_name: String = ""      # "Iron Sword"
@export var texture: Texture2D                # inventory icon (optional for now)

# Static stats (authoring-time)
@export var attack: int = 5
@export var durability: int = 20
