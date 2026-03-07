extends Node
class_name InputHandler

@onready var main: CharacterBody2D = get_parent(); 
@export var interactReceiver: InteractReceiver

func _process(delta: float) -> void:
	main.wishDir = Input.get_vector("Left", "Right", "Up", "Down");
	

func _input(event: InputEvent) -> void:
	if (event is InputEventMouse): return;
	
	if interactReceiver:
		if event.is_action_pressed("Interact"):
			interactReceiver.try_to_interact()
