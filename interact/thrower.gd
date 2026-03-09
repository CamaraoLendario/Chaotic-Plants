extends Node2D
class_name Thrower

signal threw()

@export var maxThrowForce: float = 2000
@export var minThrowForce: float = 500
@export var maxThrowChargeTime: float = 1.5

@export_group("References")
@export var picker: Picker

var currentThrowForce: float
var throwForcePerSecond: float
var isThrowing: bool = false


func _ready() -> void:
	throwForcePerSecond = (maxThrowForce-minThrowForce) / maxThrowChargeTime
	reset_throw_force()

func _process(delta: float) -> void:
	if isThrowing:
		currentThrowForce += throwForcePerSecond * delta

func start_throwing():
	if !picker.is_holding():
		print("Tried to throw but picker is not holding anything!")
		return
		
	isThrowing = true

func stop_throwing():
	if picker.is_holding():
		throw()
	isThrowing = false
	reset_throw_force()

func throw():
	var pickable: Pickable = picker.drop_pickable()
	var pickableOwner = pickable.owner
	if pickableOwner is RigidBody2D:
		pickableOwner.apply_central_impulse(Vector2.from_angle(global_rotation) * currentThrowForce)
		threw.emit()
	else:
		print("Tried throwing ", pickableOwner.name, " but it is not a RigidBody!")

func reset_throw_force():
	currentThrowForce = minThrowForce
