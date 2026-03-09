extends Plant
class_name clumsy_goober

@export_group("references")
@export var strawberryImage: Sprite2D
@export var strawberrySpawn: Marker2D
@export var stawberryScene: PackedScene

@onready var strawberry: Strawberry = stawberryScene.instantiate()
var spawnBerryTimer: Timer = Timer.new()
var hasStrawberry: bool = true

func _ready() -> void:
	super._ready()
	get_tree().get_first_node_in_group("World").add_child(strawberry)
	strawberry.mother = self
	if (global_position.y > 0):
		strawberrySpawn.position.y *= -1
	strawBerryTake()
	
	picker.picked_up_pickable.connect(onTook)
	add_child(spawnBerryTimer)
	spawnBerryTimer.one_shot = true
	spawnBerryTimer.start(2)
	spawnBerryTimer.timeout.connect(onTimeout)

func onTook(obj: Pickable):
	if (obj.owner is Strawberry and !hasStrawberry):
		var newStrawberry : Strawberry = obj.owner
		if (newStrawberry.mother != self):
			var otherMother: clumsy_goober = newStrawberry.mother
			var myStrawberry: Strawberry = strawberry
			strawberry = newStrawberry
			otherMother.strawberry = myStrawberry
		
		strawBerryTake()


func onTimeout():
	if (randf() < 0.5):
		strawBerrySpawn()
	else: spawnBerryTimer.start(2)

func strawBerrySpawn():
	isGrowing = false
	hasStrawberry = false
	strawberryImage.hide()
	strawberry.global_position = strawberrySpawn.global_position
	strawberry.input.enable()
	strawberry.moranguinhosound.play(0)

func strawBerryTake():
	isGrowing = true
	hasStrawberry = true
	strawberryImage.show()
	strawberry.global_position = Vector2.ONE * 10000
	strawberry.input.disable()
	strawberry.moranguinhosound.stop()

func finishGrowing():
	super.finishGrowing()
	strawBerryTake()
