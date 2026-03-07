extends Plant
class_name CryBaby

@export_category("Nodes")
@export var itemReceiver: PlantItemReceiver
@export var teddyBearScene: PackedScene

var ownedTeddyBears: Array[TeddyBear]

var WantedTeddyBear: int:
	get():
		return wantedTeddyBear
	set(value):
		wantedTeddyBear = value
		checkIsCrying()
var wantedTeddyBear: int = randi_range(0, 2)

var HeldTeddyBear: int:
	get():
		return heldTeddyBear
	set(value):
		heldTeddyBear = value
		checkIsCrying()
var heldTeddyBear = -1

func _ready() -> void:
	super._ready()
	
	itemReceiver.picked_up_object.connect(checkIsCrying)
	itemReceiver.dropped_object.connect(checkIsCrying)
	
	SpawnTeddyBears()

func checkIsCrying() -> bool:
	var currentHeldObject = itemReceiver.get_held_object()
	if (currentHeldObject is not TeddyBear): return false
	currentHeldObject = currentHeldObject as TeddyBear
	
	if (wantedTeddyBear == currentHeldObject.representedBear):
		return true
	else: return false

func SpawnTeddyBears():
	for i in 3: #aparentemente isto faz 0, 1, 2
		var teddyBear: TeddyBear = teddyBearScene.instantiate()
		teddyBear.representedBear = i
		
		var angle = randf() * PI * 2
		position = Vector2(cos(angle), sin(angle)) * randf() * 30
		
		get_tree().get_first_node_in_group("World").call_deferred("add_child", teddyBear)
		 
