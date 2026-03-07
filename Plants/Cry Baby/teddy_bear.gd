extends ProtoObject
class_name TeddyBear

@export_category("Nodes")
@export var sprite: AnimatedSprite2D

var representedBear: int = 0

func _ready() -> void:
	sprite.frame = representedBear
