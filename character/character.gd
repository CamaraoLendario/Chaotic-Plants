extends CharacterBody2D
class_name Character

@export var acceleration : float = 4000.0
var drag : float = 3000.0
var wishDir : Vector2 = Vector2.ZERO
var maxSpeed : float = 500.0

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
