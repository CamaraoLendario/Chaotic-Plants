extends Plant
class_name Steamy

var min: float = 0.4
var max: float = 0.6
var steamMeter: float: # goes from 0 to 1
	get():
		return progressBar.value
	set(value):
		progressBar.value = value

var direction: int = 1
var timer: Timer = Timer.new()
var directionChangeInterval: float = 3

@export_category("Node")
@export var itemReceiver: PlantItemReceiver
@export var progressBar: ProgressBar

func _ready() -> void:
	super._ready()
	
	timer.start(directionChangeInterval)
	timer.one_shot = true
	timer.timeout.connect(directionChange)
	
	itemReceiver.picked_up_object.connect(itemreceived)

func _process(delta: float) -> void:
	steamMeter += direction * delta / 6
	clamp(steamMeter, 0, 1)

func _physics_process(delta: float) -> void:
	# TODO: 
	# isto é estúpido, temos de ter um bool na planta
	# a dizer se pode ou não crescer
	if (steamMeter < max and steamMeter > min):
		super._physics_process(delta) 

func directionChange():
	timer.start(directionChangeInterval)
	
	if (randf() < 0.75):
		direction *= -1

func add_water():
	steamMeter += 0.2

func itemreceived(obj: Pickable):
	if (obj.owner is not WaterBucket): return
	
	var waterBucket: WaterBucket = obj.owner
	itemReceiver.objectHolder.drop().owner.queue_free()
	itemReceiver.objectHolder.start_holding(waterBucket.pickable)
