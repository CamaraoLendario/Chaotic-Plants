extends Node2D
class_name Pot

@export_category("Nodes")
@export var itemReceiver: PlantItemReceiver

func _ready() -> void:
	itemReceiver.picked_up_object.connect(on_picked_up_object)
	#itemReceiver.dropped_object.connect()

func on_picked_up_object(pickable: Pickable):
	var obj = pickable.owner
	
	if (obj is Seed):
		var seedBag: Seed = obj
		var plant: Plant = seedBag.get_plant()
		add_child(plant)
		itemReceiver.objectHolder.drop().owner.queue_free()
		itemReceiver.objectHolder.start_holding(plant.pickable)
