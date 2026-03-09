extends Node
class_name InputHandler

@onready var main: Character = get_parent();

@export_group("References")
@export var interactor: Interactor
@export var picker: Picker
@export var thrower: Thrower
@export var anchor: Node2D

func _process(delta: float) -> void:
	main.wishDir = Input.get_vector("Left", "Right", "Up", "Down");
	
	if get_viewport().get_camera_2d():
		var mouseScreenPos = get_viewport().get_camera_2d().get_global_mouse_position()
		main.aimDir = anchor.global_position.direction_to(mouseScreenPos)
	
	if Input.is_action_just_pressed("Throw"):
		thrower.start_throwing()
	if Input.is_action_just_released("Throw"):
		thrower.stop_throwing()
	
	if Input.is_action_just_pressed("Interact"):
		interactor.start_interacting()
	if Input.is_action_just_released("Interact"):
		interactor.stop_interacting()
	
	if Input.is_action_just_pressed("PickUp") and !picker.is_holding():
		picker.pick_up_pickable()
	elif Input.is_action_just_pressed("Drop") and picker.is_holding():
		picker.drop_pickable()
