class_name Interactable extends Area2D

signal wasInteracted(interactor: Node2D)

func interact(interactor: Node2D) -> void:
	wasInteracted.emit(interactor)
	print(interactor.name, " interacted with me")
