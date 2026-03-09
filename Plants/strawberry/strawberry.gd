extends Character
class_name Strawberry

@export var pickable: Pickable
@export var input: RunawayAI
@export var sprite: Sprite2D
@onready var moranguinhosound: AudioStreamPlayer2D = $AudioStreamPlayer2D

var mother: clumsy_goober

func _ready() -> void:
	pickable.WasPickedUp.connect(func(_x):
		print("Strawberry stopped")
		input.disable()
		position *= 0
		velocity *= 0
		moranguinhosound.stop()
		)
	
	pickable.WasDropped.connect(func(_x):
		print("Strawberry started")
		input.enable()
		moranguinhosound.play(0)
		)

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	sprite.rotation += velocity.x/10 * delta
