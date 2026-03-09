extends Plant

@export_group("references")
@export var strawberryImage: Sprite2D
@export var strawberrySpawn: Marker2D
@export var stawberryScene: PackedScene

@onready var strawberry: Strawberry = stawberryScene.instantiate()
var spawnBerryTimer: Timer = Timer.new()

func _ready() -> void:
	super._ready()
	get_tree().get_first_node_in_group("World").add_child(strawberry)
	if (global_position.y > 0):
		strawberrySpawn.position.y *= -1
	
	picker.picked_up_pickable.connect(onTook)
	
	add_child(spawnBerryTimer)
	spawnBerryTimer.one_shot = true
	spawnBerryTimer.start(2)
	spawnBerryTimer.timeout.connect(onTimeout)

func onTook(obj: Pickable):
	if (obj.owner is not Strawberry):
		pass

func onTimeout():
	if (randf() < 0.5):
		strawBerrySpawn()
	else: spawnBerryTimer.start(2)

func strawBerrySpawn():
	strawberryImage.hide()
	strawberry.global_position = strawberrySpawn.global_position
	strawberry.input.enable()

func strawBerryTake():
	strawberryImage.show()
	strawberry.global_position = Vector2.ONE * 10000
	strawberry.input.disable()
