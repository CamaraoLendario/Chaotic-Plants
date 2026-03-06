extends Area2D
class_name Interactable

func interact(interactor: Node2D) -> void:
	print($" {interactor.name} interacted with me")
