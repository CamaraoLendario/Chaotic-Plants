extends CharacterBody2D
class_name Character

@export var acceleration : float = 4000.0
@export var drag : float = 3000.0
@export var maxSpeed : float = 500.0
@export var litterPushForce: float = 100.0

@export_group("References")
@export var anchor: Node2D
@export var picker: Picker
@export var objectHolder: ObjectHolder

var wishDir : Vector2 = Vector2.ZERO
var aimDir : Vector2 = Vector2.ZERO

func _ready() -> void:
	picker.picked_up_pickable.connect(func(pickable: Pickable):
		pickable.canBePicked = false
		)
	
	picker.dropped_pickable.connect(func(pickable: Pickable):
		pickable.canBePicked = true
		)

func _physics_process(delta: float) -> void:
	var initialVelDir : Vector2 = velocity.normalized()
	var accelerationVector : Vector2 = wishDir * acceleration * delta
	var dragVector : Vector2 = -initialVelDir * drag * delta
	
	velocity += accelerationVector
	velocity += dragVector
	
	if (initialVelDir.dot(velocity) < 0):
		velocity *= 0
	
	if (velocity.length_squared() > maxSpeed * maxSpeed):
		velocity = velocity.normalized() * maxSpeed
	
	move_and_slide()
	
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal() * litterPushForce)
	
	anchor.rotation = aimDir.angle()
