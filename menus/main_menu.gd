extends Control

@export var start_game_button: Button
@export var quit_button: Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_game_button.pressed.connect(change_to_game_scene)
	quit_button.pressed.connect(quit_game)

func change_to_game_scene():
	get_tree().change_scene_to_file("res://main_world.tscn")

func quit_game():
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()
