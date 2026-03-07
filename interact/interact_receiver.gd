extends Area2D
class_name InteractReceiver

@export var objectHolder: ObjectHolder

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
