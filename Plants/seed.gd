extends ProtoObject
class_name Seed

@export var plantData: PlantData

func _ready() -> void:
	super._ready()
	self.name = plantData.name + " seed"
	$Label.text = name

func get_plant() -> Plant:
	return plantData.scene.instantiate()
