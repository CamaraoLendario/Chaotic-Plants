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

var isGrowing: bool = true

var IsPlanted: bool:
	get():
		return isPlanted
	set(value):
		isPlanted = value
		(material as ShaderMaterial).set_shader_parameter("animate", value)
		

var isPlanted: bool = false
var data: PlantData
var isGrown : bool = false
var GrowProgress : float: ## How far the plant is in the growing progress. from 0 to growGoal
	get():
		return growProgress
	set(value):
		growProgress = value
		check_grow_progress()
var growProgress: float = 0


func _ready() -> void:
	interactable.wasInteracted.connect(on_interacted)
	if data == null:
		printerr("Plant ", name, " does not have data set. Null errors will occur!")
	(material as ShaderMaterial).set_shader_parameter("startTime", randf()*2*PI) ## doesnt really get any time, but this is simpler and does the same effect

func set_data(plantData: PlantData):
	data = plantData

func grow():
	if (isGrown or GrowProgress >= growGoal): return
	GrowProgress += 1
	grew.emit()

func on_interacted(_interactor: Node2D):
	print("I was interacted with")

func _physics_process(delta: float) -> void:
	if (!isByStages and GrowProgress < growGoal-1 and isGrowing):
		GrowProgress += (delta / growTime) * growGoal

func check_grow_progress():
	sprite.animation = "stage" +  str(int(GrowProgress))
	if (growProgress >= growGoal-1):
		isGrown = true
