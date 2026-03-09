extends Node2D
class_name Pot

@export_category("Nodes")
@export var itemReceiver: PlantItemReceiver

func _ready() -> void:
	itemReceiver.picked_up_object.connect(on_picked_up_object)
	#itemReceiver.dropped_object.connect()

func on_picked_up_object(obj: Pickable):
	var seed: Seed = obj.owner
	
