extends Label

@export var gameController: GameController

func _process(delta: float) -> void:
	text = to_time_string(int(gameController.get_elapsed_time()))

func to_time_string(total_seconds: int) -> String:
	var format_string = "%02d:%02d"
	var minutes: int = total_seconds / 60
	var seconds: int = total_seconds % 60
	return format_string % [minutes, seconds]
