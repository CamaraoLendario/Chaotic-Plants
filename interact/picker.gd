extends Area2D
class_name Picker

signal picked_up_pickable(pickable: Pickable)
signal dropped_pickable(pickable: Pickable)

@export var objectHolder: ObjectHolder

@export var filters: Array[InteractFilter]
var curPickingTarget: Pickable

func _ready() -> void:
	objectHolder.dropped_object.connect(func(obj): 
		print("2")
		dropped_pickable.emit(obj)
		)

func _physics_process(delta: float) -> void:
	if !is_holding():
		curPickingTarget = select_current_pickable()

func select_current_pickable() -> Pickable:
	var overlappingAreas = get_overlapping_areas()
	
	# sort by ascending distance to interactor
	overlappingAreas.sort_custom(func (a: Area2D, b: Area2D): return a.global_position.distance_to(global_position) < b.global_position.distance_to(global_position))
	
	for overlappingArea in overlappingAreas:
		if overlappingArea is Pickable and check_filter_allows(overlappingArea.owner):
			return overlappingArea
	return null

func check_filter_allows(obj) -> bool:
	if (filters.is_empty()):
		return true
	for filter in filters:
		if (filter.is_allowed(obj)): return true
	return false

#func pick_up_pickable():
	#if !is_holding():
		#if has_target():
			#curPickingTarget.get_picked(self)
			#objectHolder.hold_object(curPickingTarget)
			#picked_up_pickable.emit(curPickingTarget)

func pick_up_pickable(pickable: Pickable = null) -> bool:
	if is_holding():
		return false
	if (has_target() and pickable == null and curPickingTarget != pickable):
		pickable = curPickingTarget
	if (pickable == null or !pickable.can_be_picked()):
		return false
	
	pickable.get_picked(self)
	objectHolder.hold_object(pickable)
	picked_up_pickable.emit(pickable)
	return true

func drop_pickable() -> Pickable:
	if is_holding():
		curPickingTarget.get_dropped(self)
		objectHolder.drop_object()
		dropped_pickable.emit(curPickingTarget)
		return curPickingTarget
	
	return null

func drop_and_free() -> Pickable:
	if is_holding():
		curPickingTarget.get_dropped(self)
		dropped_pickable.emit(curPickingTarget)
		objectHolder.drop_and_free()
		return curPickingTarget
	
	return null

func is_holding() -> bool:
	return objectHolder.is_holding()

func has_target() -> bool:
	return curPickingTarget != null
