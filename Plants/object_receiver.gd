extends Node2D
class_name  PlantItemReceiver

signal picked_up_object(obj: Pickable)
signal dropped_object(obj: Pickable)

@export var picker: Picker
@export var filters: Array[InteractFilter]

func _ready() -> void:
	picker.filters = filters #bad code design, should work
	picker.picked_up_pickable.connect(_on_picked_up_object)
	picker.dropped_pickable.connect(_on_dropped_object)

func _process(delta: float) -> void:
	#TODO: costly but it should work
	try_to_pick_up()

func _on_picked_up_object(obj: Pickable):
	picked_up_object.emit(obj)

func _on_dropped_object(obj: Pickable):
	dropped_object.emit(obj)

func try_to_pick_up(pickable: Pickable = null):
	return picker.pick_up_pickable(pickable)

func drop() -> Pickable:
	return picker.drop_pickable()

func drop_and_free() -> Pickable:
	return picker.drop_and_free()

func get_held_object() -> Pickable:
	return picker.objectHolder.currentHoldedObject
