class_name Interactable extends Area2D

signal wasInteracted(interactor: InteractReceiver)

func interact(interactor: InteractReceiver) -> void:
	wasInteracted.emit(interactor)
	print(interactor.owner.name, " interacted with ", name)
