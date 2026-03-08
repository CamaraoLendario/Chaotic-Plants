extends Area2D
class_name Interactor

var curInteractingTarget: Interactable

var isInteracting: bool = false

func _physics_process(delta: float) -> void:
	#TODO: very expensive, but should be fine
	if !isInteracting:
		curInteractingTarget = pick_current_interactable()

func pick_current_interactable() -> Interactable:
	var overlappingAreas = get_overlapping_areas()
	
	# sort by ascending distance to interactor
	overlappingAreas.sort_custom(func (a: Area2D,b: Area2D): return a.global_position.distance_to(global_position) < b.global_position.distance_to(global_position))
	
	for overlappingArea in overlappingAreas:
		if overlappingArea is Interactable:
			return overlappingArea
	return null

func start_interacting():
	if has_target():
		curInteractingTarget.start_interaction(self)
	isInteracting = true

func stop_interacting():
	if has_target():
		curInteractingTarget.stop_interaction(self)
	isInteracting = false

func has_target() -> bool:
	return curInteractingTarget != null
