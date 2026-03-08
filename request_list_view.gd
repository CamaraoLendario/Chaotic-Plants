extends HBoxContainer

@export var gameController: GameController

@export var requestViewScene: PackedScene

func _ready() -> void:
	gameController.newRequestArrived.connect(_on_new_request)

func _on_new_request(request: PlantRequest):
	var requestView: RequestView = requestViewScene.instantiate()
	requestView.set_request(request)
	add_child(requestView)
