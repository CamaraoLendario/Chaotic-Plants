extends Node2D
class_name Plant

# TODO: 
# Receive Item

signal grew (growStage : int)
@export var isByStages : bool = false
@export var growTime : float = 1 ## Time to grow in seconds
@export var growGoal : int = 3 ## How many stages the plant has
@export_group("Nodes")
@export var interactable : Interactable
@export var sprite: AnimatedSprite2D

var data: PlantData
var isGrown : bool = false
var GrowProgress : float: ## How far the plant is in the growing progress. from 0 to growGoal
	get():
		return growProgress
	set(value):
		growProgress = value
		check_grow_progress()
var growProgress: float = 1


func _ready() -> void:
	interactable.wasInteracted.connect(on_interacted)
	if data == null:
		printerr("Plant ", name, " does not have data set. Null errors will occur!")

func set_data(plantData: PlantData):
	data = plantData

func grow():
	if (isGrown): return
	GrowProgress += 1
	grew.emit()

func on_interacted(_interactor: Node2D):
	print("I was interacted with")

func _physics_process(delta: float) -> void:
	if (!isByStages and GrowProgress < growGoal):
		GrowProgress += (delta / growTime) * growGoal

func check_grow_progress():
	sprite.animation = "stage" +  str(int(GrowProgress)-1)
	if (growProgress >= growGoal):
		isGrown = true
