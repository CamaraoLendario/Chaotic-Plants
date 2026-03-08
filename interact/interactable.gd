class_name Interactable extends Area2D

signal interactionStarted(interactor: Interactor)
signal interactionEnded(interactor: Interactor)

func start_interaction(interactor: Interactor) -> void:
	interactionStarted.emit(interactor)
	print(interactor.owner.name, " started interaction with ", owner.name)

func stop_interaction(interactor: Interactor) -> void:
	interactionEnded.emit(interactor)
	print(interactor.owner.name, " stopped interaction with ", owner.name)
	pass
