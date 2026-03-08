extends Plant
class_name Steamy

var min: float = 0.4
var max: float = 0.6
var steamMeter: float = 0.15 # goes from 0 to 1
var direction: int = 1
var timer: Timer = Timer.new()
var directionChangeInterval: float = 3

@export_category("Node")
@export var itemReceiver: PlantItemReceiver

func _ready() -> void:
	super._ready()
	
	timer.start(directionChangeInterval)
	timer.one_shot = true
	timer.timeout.connect(directionChange)
	
	

func _process(delta: float) -> void:
	steamMeter += direction * delta / 6

func directionChange():
	timer.start(directionChangeInterval)
	
	if (randf() < 0.75):
		direction *= -1

func add_water():
	steamMeter += 0.2
