extends Plant
class_name CryBaby

@export_category("Nodes")
@export var itemReceiver: PlantItemReceiver
@export var teddyBearScene: PackedScene

var beAnnoyingTimeInterval: float = 1
var ownedTeddyBears: Array[TeddyBear]

var isCrying: bool = true

var WantedTeddyBear: int:
	get():
		return _wantedTeddyBear
	set(value):
		_wantedTeddyBear = value
		checkIsCrying()
var _wantedTeddyBear: int = randi_range(0, 2)

var HeldTeddyBear: int:
	get():
		return _heldTeddyBear
	set(value):
		_heldTeddyBear = value
		checkIsCrying()
var _heldTeddyBear = -1

func _ready() -> void:
	super._ready()
	
	itemReceiver.picked_up_object.connect(update_held_item)
	itemReceiver.dropped_object.connect(update_held_item)
	
	AddBeAnnoyingTimer()
	SpawnTeddyBears()

func AddBeAnnoyingTimer():
	var be_annoying_timer: Timer = new().Timer()
	add_child(be_annoying_timer)
	be_annoying_timer.start(beAnnoyingTimeInterval)
	be_annoying_timer.timeout.connect(be_annoying)

func be_annoying():
	var possibleTeddyBears = [0, 1, 2]
	possibleTeddyBears.remove_at(WantedTeddyBear)
	if(randi_range(0, 1) == 0):
		WantedTeddyBear = possibleTeddyBears[randi_range(0, 1)]

func update_held_item(_obj: Pickable):
	var currentHeldObject = itemReceiver.get_held_object()
	if (currentHeldObject is TeddyBear):
		var newTeddyBear = currentHeldObject as TeddyBear
		WantedTeddyBear = newTeddyBear.representedBear
		
		if (newTeddyBear.ownerBaby != self):
			trade_teddy_bears(newTeddyBear)
		
	else: WantedTeddyBear = -1

func checkIsCrying():
	if (WantedTeddyBear == HeldTeddyBear):
		isCrying = false
	else: isCrying = true

func SpawnTeddyBears():
	for i in 3: #aparentemente isto faz 0, 1, 2
		var teddyBear: TeddyBear = teddyBearScene.instantiate()
		teddyBear.representedBear = i
		teddyBear.ownerBaby = self
		ownedTeddyBears.append(teddyBear)
		var angle = randf() * PI * 2
		teddyBear.position = Vector2(cos(angle), sin(angle)) * randf() * 100
		
		get_tree().get_first_node_in_group("World").call_deferred("add_child", teddyBear)
		 

func trade_teddy_bears(teddyBear: TeddyBear):
	var tradingWith: CryBaby = teddyBear.ownerBaby
	var bearIdx = teddyBear.representedBear
	var otherBear = tradingWith.ownedTeddyBears[bearIdx]
	
	ownedTeddyBears[bearIdx] = otherBear
	tradingWith.ownedTeddyBears[bearIdx] = teddyBear


func _exit_tree() -> void:
	for teddyBear in ownedTeddyBears:
		teddyBear.queue_free()
