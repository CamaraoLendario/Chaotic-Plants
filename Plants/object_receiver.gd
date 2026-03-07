extends Node2D
signal picked_up_object(obj: Pickable)

@export var interactReceiver: InteractReceiver
@export var objectHolder: ObjectHolder

func _enter_tree() -> void:
	interactReceiver.interactableInRange.connect(_on_interactable_in_range)
	objectHolder.picked_up_object.connect(_on_picked_up_object)

func _on_interactable_in_range(interactable: Interactable):
	if interactable is Pickable:
		interactable.interact(interactReceiver)

func _on_picked_up_object(obj: Pickable):
	picked_up_object.emit(picked_up_object)
