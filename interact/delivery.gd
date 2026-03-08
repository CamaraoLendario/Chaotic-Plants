extends Node2D
class_name Delivery

signal plant_delivered(plant: Plant)

@export var filters: Array[InteractFilter]

@export_group("References")
@export var interactReceiver: InteractReceiver

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interactReceiver.interactableInRange.connect(_on_interactable_in_range)
	interactReceiver.filters = filters

func _on_interactable_in_range(interactable: Interactable):
	if interactable is Pickable:
		pick_up(interactable)

func pick_up(interactable: Interactable):
	interactable.interact(interactReceiver)
	plant_delivered.emit(interactable.owner)
