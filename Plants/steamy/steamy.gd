extends Plant
class_name Steamy

signal stopped_growing()

var min: float = 0.4
var max: float = 1
var steamMeter: float

var direction: int = -1
var timer: Timer = Timer.new()
var directionChangeInterval: float = 1.5

@export_category("Node")
@export var itemReceiver: PlantItemReceiver
@export var progressBar: ProgressBar

func _ready() -> void:
	super._ready()
	
	progressBar.max_value = 1
	progressBar.min_value = 0
	progressBar.step = 0.001
	
	add_child(timer)
	timer.one_shot = true
	timer.timeout.connect(directionChange)
	timer.start(directionChangeInterval)
	
	itemReceiver.picked_up_object.connect(itemreceived)

func _process(delta: float) -> void:
	set_steam_meter(steamMeter + (direction * delta / 20))
	set_steam_meter(clamp(steamMeter, 0, 1))

func _physics_process(delta: float) -> void:
	isGrowing = (steamMeter < max and steamMeter > min)
	if (isGrowing): 
		sprite.animation = "stage2"
		stopped_growing.emit()
	else:
		sprite.animation = "stage0"
	super._physics_process(delta)
	#if (isGrowing): print(growProgress)

func directionChange():
	return
	timer.start(directionChangeInterval)
	
	if (randf() < 0.75):
		direction *= -1

func add_water():
	set_steam_meter(steamMeter + 0.5)

func itemreceived(obj: Pickable):
	if (obj.owner is not WaterBucket): return
	
	var waterBucket: WaterBucket = obj.owner
	itemReceiver.drop_and_free()
	add_water()

func set_steam_meter(value: float):
	steamMeter = value
	progressBar.value = steamMeter

func check_grow_progress():
	pass
