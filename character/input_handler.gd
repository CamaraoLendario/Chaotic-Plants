extends Node
class_name InputHandler

@onready var main: CharacterBody2D = get_parent(); 

func _input(event: InputEvent) -> void:
	if (event is InputEventMouse): return;
	
	main.wishDir = Input.get_vector("Left", "Right", "Up", "Down");
