extends Node2D
class_name Pot

@export_category("Nodes")
@export var itemReceiver: PlantItemReceiver

func _ready() -> void:
	itemReceiver.picked_up_object.connect(on_picked_up_object)
	#itemReceiver.dropped_object.connect()

func on_picked_up_object(obj: Pickable):
	if (obj.owner is not Seed): return
	var seed: Seed = obj.owner
	var plant: Plant = seed.plantData.scene.instantiate()
	add_child(plant)
	itemReceiver.drop_and_free()
	var successfulPickup = itemReceiver.try_to_pick_up(plant.pickable)
	if (!successfulPickup):
		printerr("Could not spawn plant. deleting it")
		plant.queue_free()
