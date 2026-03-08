extends ProtoObject
class_name TeddyBear

@export_category("Nodes")
@export var sprite: AnimatedSprite2D

var representedBear: int = 0
var ownerBaby: CryBaby

func _ready() -> void:
	super._ready()
	sprite.frame = representedBear
