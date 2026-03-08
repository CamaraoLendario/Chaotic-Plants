extends Area2D
class_name Picker

@export var objectHolder: ObjectHolder

var curPickingTarget: Pickable

func _physics_process(delta: float) -> void:
	if !is_holding():
		curPickingTarget = select_current_pickable()

func select_current_pickable() -> Pickable:
	var overlappingAreas = get_overlapping_areas()
	
	# sort by ascending distance to interactor
	overlappingAreas.sort_custom(func (a: Area2D, b: Area2D): return a.global_position.distance_to(global_position) < b.global_position.distance_to(global_position))
	
	for overlappingArea in overlappingAreas:
		if overlappingArea is Pickable:
			return overlappingArea
	return null

func pick_up_pickable():
	if !is_holding():
		if has_target():
			curPickingTarget.get_picked(self)
			objectHolder.hold_object(curPickingTarget)

func drop_pickable() -> Pickable:
	if is_holding():
		curPickingTarget.get_dropped(self)
		objectHolder.drop_object()
		return curPickingTarget
	
	return null

func is_holding() -> bool:
	return objectHolder.is_holding()

func has_target() -> bool:
	return curPickingTarget != null
