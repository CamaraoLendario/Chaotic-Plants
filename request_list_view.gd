extends HBoxContainer

@export var gameController: GameController

@export var requestViewScene: PackedScene

func _ready() -> void:
	gameController.newPlantSpawned.connect(_on_plant_spawned)

func _on_plant_spawned(plant: Plant):
	var requestView: RequestView = requestViewScene.instantiate()
	add_child(requestView)
	requestView.set_plant(plant)
