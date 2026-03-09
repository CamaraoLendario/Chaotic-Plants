extends Character
class_name Strawberry

@export var pickable: Pickable
@export var input: RunawayAI

func _ready() -> void:
	pickable.WasPickedUp.connect(func(x):
		input.disable()
		position = Vector2.ZERO
		)
	
	pickable.WasDropped.connect(func(x):
		input.enable()
		)
