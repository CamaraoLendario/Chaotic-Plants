extends PanelContainer

@export var gameController: GameController
@export var resume_button: Button
@export var menu_button: Button
@export var quit_button: Button
@export var main_menu: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resume_button.pressed.connect(resume_game)
	menu_button.pressed.connect(change_to_menu_scene)
	quit_button.pressed.connect(quit_game)
	
	gameController.gameResumed.connect(hide)
	gameController.gamePaused.connect(show)

func resume_game():
	gameController.resume_game()

func change_to_menu_scene():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://menus/main_menu.tscn")

func quit_game():
	get_tree().paused = false
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()

#func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("Pause"):
		#resume_game()
