extends CharacterBody2D
class_name Character

@export var acceleration : float = 4000.0
@export var drag : float = 3000.0
@export var maxSpeed : float = 500.0

@export_group("References")
@export var anchor: Node2D
@export var objectHolder: ObjectHolder
@export var interactReceiver: InteractReceiver

var wishDir : Vector2 = Vector2.ZERO
var aimDir : Vector2 = Vector2.ZERO

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
	
	anchor.rotation = aimDir.angle()
	
