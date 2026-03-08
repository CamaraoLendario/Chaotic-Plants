extends Node2D
class_name  PlantItemReceiver

signal picked_up_object(obj: Pickable)
signal dropped_object(obj: Pickable)

@export var interactReceiver: InteractReceiver
@export var objectHolder: ObjectHolder
@export var filters: Array[InteractFilter]:
	get():
		return interactReceiver.filters
	set(value):
		interactReceiver.filters = value

func _ready() -> void:
	interactReceiver.interactableInRange.connect(_on_interactable_in_range)
	objectHolder.picked_up_object.connect(_on_picked_up_object)
	objectHolder.dropped_object.connect(_on_dropped_object)

func _on_interactable_in_range(interactable: Interactable):
	if interactable is Pickable:
		interactable.interact(interactReceiver)

func _on_picked_up_object(obj: Pickable):
	picked_up_object.emit(obj)

func _on_dropped_object(obj: Pickable):
	dropped_object.emit(obj)

func get_held_object():
	if (!objectHolder.objectHoldPoint.get_child_count() > 0): return null
	return objectHolder.objectHoldPoint.get_child(0) 
