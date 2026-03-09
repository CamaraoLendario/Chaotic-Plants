extends Node2D
class_name GameController

signal levelSelected(levelData: LevelData)
signal newRequestArrived(request: PlantRequest)
signal newPlantSpawned(plant: Plant)

signal requestFulfilled(request: PlantRequest, plant: Plant)
signal wrongPlantDelivered(plant: Plant)

signal gamePaused()
signal gameResumed()

@export var gameTime: float = 60 # 300 = 5 minutes
@export var levelData: LevelData

@export_group("References")
@export var plantSpawners: Array[ObjectSpawner] #TODO: remove spawners
@export var delivery: Delivery

const MAIN_MENU = preload("uid://bap8m7lddbrd7")


var activeRequests: Array[PlantRequest]

var requestIndex: int = -1
var timeElapsed: float = 0
var nextRequestTime: float

func _ready() -> void:
	setup_next_request_time()
	
	delivery.plant_delivered.connect(_on_delivery)

func _process(delta: float) -> void:
	timeElapsed += delta
	
	if timeElapsed >= nextRequestTime:
		handle_request(next_request())
		newRequestArrived.emit(next_request())
		print("NEW REQUEST at index ", requestIndex ,": ", next_request().plantData.name)
		if has_next_request():
			setup_next_request_time()
		else:
			get_tree().change_scene_to_packed(MAIN_MENU)

func handle_request(request: PlantRequest):
	activeRequests.append(request)

# deprecated
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

func _on_delivery(plant: Plant):
	for request in activeRequests:
		#TODO: check if plant is grown etc etc
		if request.plantData == plant.data:
			_fulfill_request(request, plant)
			return
	_signal_failed_request(plant)

func _fulfill_request(request: PlantRequest, plant: Plant):
	requestFulfilled.emit(request, plant)
	activeRequests.erase(request)
	print("request fulfilled!")
	request.requestFulfilled.emit()
	plant.call_deferred("queue_free")

func _signal_failed_request(plant: Plant):
	print("delivery failed!")
	plant.call_deferred("queue_free")

func resume_game():
	get_tree().paused = false
	gameResumed.emit()

func pause_game():
	get_tree().paused = true
	gamePaused.emit()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause"):
		if get_tree().paused:
			resume_game()
		else:
			pause_game()

#deprecated
func on_plant_spawned(obj: Node2D):
	pass
