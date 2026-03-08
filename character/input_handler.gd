extends Node
class_name InputHandler

@onready var main: Character = get_parent(); 
@export var interactReceiver: InteractReceiver

@export_group("Nodes")
@export var anchor: Node2D

func _process(delta: float) -> void:
	main.wishDir = Input.get_vector("Left", "Right", "Up", "Down");
	
	if get_viewport().get_camera_2d():
		var mouseScreenPos = get_viewport().get_camera_2d().get_global_mouse_position()
		main.aimDir = anchor.global_position.direction_to(mouseScreenPos)
	
	if Input.is_action_pressed("Throw"):
		interactReceiver.start_throw(delta)
	
	if Input.is_action_just_released("Throw"):
		interactReceiver.stop_throw()

func _input(event: InputEvent) -> void:
	if (event is InputEventMouse): return;
	
	if interactReceiver:
		if event.is_action_pressed("Interact"):
			interactReceiver.try_to_interact()
