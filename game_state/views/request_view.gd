extends PanelContainer
class_name RequestView

@export var plant_name: Label
@export var plant_progress: ProgressBar
@export var plant_needs: Label

var plant: Plant

func set_plant(plant: Plant):
	self.plant = plant
	
	plant_name.text = plant.name #TODO: fix this, use plantData (put field in Plant script)
	plant_progress.max_value = plant.growGoal
	plant_progress.value = plant.GrowProgress

func _process(delta: float) -> void:
	if plant:
		plant_progress.value = plant.GrowProgress
