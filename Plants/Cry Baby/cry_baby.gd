extends Plant
class_name CryBaby

@export_category("Nodes")
@export var itemReceiver: PlantItemReceiver
@export var teddyBearScene: PackedScene

var beAnnoyingTimeInterval: float = 1
var ownedTeddyBears: Array[TeddyBear]
var be_annoying_timer: Timer = Timer.new()

var IsCrying: bool:
	get():
		return _isCrying
	set(value):
		_isCrying = value
		if (_isCrying): 
			modulate = Color.BLUE
			isGrowing = false
		else: 
			modulate = Color.WHITE
			isGrowing = true
			if (be_annoying_timer.is_stopped()):
				print("STARTING TIMER")
				be_annoying_timer.start(beAnnoyingTimeInterval)
	
var _isCrying: bool = true

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
	
	IsCrying = true
	itemReceiver.picked_up_object.connect(update_held_item)
	itemReceiver.dropped_object.connect(update_held_item)
	
	AddBeAnnoyingTimer()
	SpawnTeddyBears()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)

func AddBeAnnoyingTimer():
	be_annoying_timer.one_shot = true
	add_child(be_annoying_timer)
	be_annoying_timer.timeout.connect(be_annoying)

func be_annoying():
	var possibleTeddyBears = [0, 1, 2]
	possibleTeddyBears.remove_at(WantedTeddyBear)
	if(randi_range(0, 1) == 0):
		WantedTeddyBear = possibleTeddyBears[randi_range(0, 1)]
	else:
		be_annoying_timer.start(beAnnoyingTimeInterval)

func update_held_item(_obj: Pickable):
	var currentHeldObject = itemReceiver.get_held_object().owner
	print(self, " held item updated. new object: ", currentHeldObject.name)
	if (currentHeldObject is TeddyBear):
		print("ohh! a teddy bear!")
		var newTeddyBear = currentHeldObject as TeddyBear
		HeldTeddyBear = newTeddyBear.representedBear
		
		if (newTeddyBear.ownerBaby != self):
			trade_teddy_bears(newTeddyBear)
	
	else:
		print("not a teddy bear")
		HeldTeddyBear = -1

func checkIsCrying():
	print("Checking is crying. wanted: ", WantedTeddyBear, " Held: ", HeldTeddyBear)
	if (WantedTeddyBear == HeldTeddyBear):
		IsCrying = false
	else: IsCrying = true

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
	otherBear.ownerBaby = self
	tradingWith.ownedTeddyBears[bearIdx] = teddyBear
	teddyBear.ownerBaby = tradingWith

func remove_bears() -> void:
	for i in 3:
		ownedTeddyBears[2-i].queue_free()
