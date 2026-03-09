extends Character
class_name Strawberry

@export var pickable: Pickable
@export var input: RunawayAI
@export var sprite: Sprite2D

var mother: clumsy_goober

func _ready() -> void:
	pickable.WasPickedUp.connect(func(_x):
		print("Strawberry stopped")
		input.disable()
		position *= 0
		velocity *= 0
		)
	
	pickable.WasDropped.connect(func(_x):
		print("Strawberry started")
		input.enable()
		)

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	sprite.rotation += velocity.x/10 * delta
