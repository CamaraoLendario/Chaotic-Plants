extends Area2D
class_name InteractReceiver

@export var objectHolder: ObjectHolder

@export_group("Throwing")
@export var maxThrowForce: float = 2000
@export var minThrowForce: float = 500
@export var maxThrowChargeTime: float = 1.5
var currentThrowForce: float
var throwForcePerSecond: float

var selectedInteractable: Interactable

var interact_interval: float = 0.5

func try_to_interact() -> void:
	print("Trying to interact")
	if objectHolder != null:
		if objectHolder.is_holding():
			objectHolder.drop()
			return
	
	if selectedInteractable:
		print("Interacting")
		selectedInteractable.interact(owner) # TODO: maybe not owner? I guess it can work

func _ready() -> void:
	reset_throw_force()
	throwForcePerSecond = (maxThrowForce-minThrowForce) / maxThrowChargeTime
	
	area_entered.connect(update_selected_interactable)
	area_exited.connect(clear_selected_interactable)

func update_selected_interactable(area: Area2D) -> void:
	if area is Interactable:
		selectedInteractable = area

func clear_selected_interactable(area: Area2D) -> void:
	# one interactable exited, but we may have more still in range
	selectedInteractable = _get_interactable_in_area() 

func _get_interactable_in_area() -> Interactable:
	var areas = get_overlapping_areas()
	for area in areas:
		if area is Interactable:
			return area
	return null

func start_throw(delta: float):
	objectHolder.move_to_drop_point()
	currentThrowForce += throwForcePerSecond * delta
	currentThrowForce = clampf(currentThrowForce, minThrowForce, maxThrowForce)

func stop_throw():
	if objectHolder:
		objectHolder.throw(Vector2.from_angle(global_rotation) * currentThrowForce)
	reset_throw_force()

func reset_throw_force():
	currentThrowForce = minThrowForce
