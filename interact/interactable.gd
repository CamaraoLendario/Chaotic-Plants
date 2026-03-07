class_name Interactable extends Area2D

signal wasInteracted(interactor: Character)

func interact(interactor: Character) -> void:
	wasInteracted.emit(interactor)
	print(interactor.name, " interacted with me")
