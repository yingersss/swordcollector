extends Control

@export var player: PlayerData

func _ready():
	set_health($PlayerPanel/PlayerData/ProgressBar, player.current_health, player.max_health)

func set_health(progress_bar, health, max_health) -> void:
	progress_bar.value = health
	progress_bar.max_value = max_health
	progress_bar.get_node("Label").text = "HP: %d/%d" % [health, max_health]
