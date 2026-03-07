class_name Interactable extends Area2D

func interact(interactor: Node2D) -> void:
	print(interactor.name, " interacted with me")
