extends Area2D
class_name InteractReceiver

var curInteractable: Interactable

var interact_interval: float = 0.5

func try_to_interact() -> void:
	print("Trying to interact")
	if curInteractable:
		print("Interacting")
		curInteractable.interact(owner) # TODO: maybe not owner? I guess it can work
	get_tree().create_timer(interact_interval).timeout.connect(try_to_interact)

func _ready() -> void:
	
	# debug
	get_tree().create_timer(interact_interval).timeout.connect(try_to_interact)
	
	area_entered.connect(update_current_interactable)
	area_exited.connect(clear_current_interactable)

func update_current_interactable(area: Area2D) -> void:
	if area is Interactable:
		curInteractable = area

func clear_current_interactable(area: Area2D) -> void:
	# one interactable left, but we may have more still in range
	curInteractable = _get_interactable_in_area() 

func _get_interactable_in_area() -> Interactable:
	var areas = get_overlapping_areas()
	for area in areas:
		if area is Interactable:
			return area
	return null
