extends PanelContainer
class_name RequestView

@export var plant_name: Label
@export var request_progress: ProgressBar
@export var plant_needs: Label

var request: PlantRequest

func set_request(request: PlantRequest):
	self.request = request
	
	plant_name.text = request.plantData.name
	request_progress.max_value = request.requestDuration
	request_progress.min_value = 0
	request_progress.value = 0
	
	request.requestFulfilled.connect(_on_request_fulfilled)

func _process(delta: float) -> void:
	if request:
		request_progress.value = request_progress.value + delta

func _on_request_fulfilled() -> void:
	# TODO: play animations?
	queue_free()
