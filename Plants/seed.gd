extends ProtoObject
class_name Seed

var plantData: PlantData

func _ready() -> void:
	name = plantData.name + " seed"
	$Label.text = name
