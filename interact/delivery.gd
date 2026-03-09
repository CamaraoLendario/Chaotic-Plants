extends Node2D
class_name Delivery

signal plant_delivered(plant: Plant)

@export var filters: Array[InteractFilter]

@export_group("References")
@export var objectReceiver: PlantItemReceiver

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	objectReceiver.Filters = filters
	objectReceiver.picked_up_object.connect(on_plant_picked_up)

func on_plant_picked_up(pickable: Pickable):
	var pickableOwner = pickable.owner
	if pickableOwner is Plant:
		plant_delivered.emit(pickable.owner)
