extends Plant
class_name Steamy

signal stopped_growing()

var min: float = 0.4
var max: float = 1
var steamMeter: float: # goes from 0 to 1
	get():
		return progressBar.value
	set(value):
		progressBar.value = value

var direction: int = -1
var timer: Timer = Timer.new()
var directionChangeInterval: float = 1.5

@export_category("Node")
@export var itemReceiver: PlantItemReceiver
@export var progressBar: ProgressBar

func _ready() -> void:
	super._ready()
	
	add_child(timer)
	timer.one_shot = true
	timer.timeout.connect(directionChange)
	timer.start(directionChangeInterval)
	
	itemReceiver.picked_up_object.connect(itemreceived)

func _process(delta: float) -> void:
	steamMeter += (direction * delta / 20)
	steamMeter = clamp(steamMeter, 0, 1)

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
	steamMeter += 0.5

func itemreceived(obj: Pickable):
	if (obj.owner is not WaterBucket): return
	
	var waterBucket: WaterBucket = obj.owner
	itemReceiver.drop_and_free()
	add_water()

func check_grow_progress():
	pass
