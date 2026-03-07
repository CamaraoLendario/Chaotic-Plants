extends Node2D
class_name GameController

signal levelSelected(levelData: LevelData)
signal newRequestArrived(request: PlantRequest)
signal newPlantSpawned(plant: Plant)

@export var gameTime: float = 60 # 300 = 5 minutes
@export var levelData: LevelData

@export_group("References")
@export var plantSpawners: Array[ObjectSpawner]

var requestIndex: int = -1
var timeElapsed: float = 0
var nextRequestTime: float

func _ready() -> void:
	setup_next_request_time()

func _process(delta: float) -> void:
	timeElapsed += delta
	
	if timeElapsed >= nextRequestTime:
		handle_request(next_request())
		newRequestArrived.emit(next_request())
		print("NEW REQUEST at index ", requestIndex ,": ", next_request().plantData.name)
		if has_next_request():
			setup_next_request_time()
		else:
			# game over
			pass

func handle_request(request: PlantRequest):
	var spawner = get_available_spawner()
	spawner.spawn(request.plantData.scene)

func get_available_spawner() -> ObjectSpawner:
	for spawner in plantSpawners:
		if spawner.can_spawn():
			return spawner
	printerr("no available spawns! This should be handled!")
	return null

func setup_next_request_time() -> void:
	requestIndex += 1
	nextRequestTime = gameTime * next_request().requestTime
	print("Next request time: ", nextRequestTime)

func has_next_request() -> bool:
	var nextIndex = requestIndex + 1
	var requestsSize = levelData.requests.size()
	return nextIndex < requestsSize

func next_request() -> PlantRequest:
	return levelData.requests[requestIndex]

func get_elapsed_time() -> float:
	return timeElapsed

func on_plant_spawned(obj: Node2D):
	newPlantSpawned.emit(obj)
