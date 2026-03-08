class_name ObjectHolder extends Node2D

signal picked_up_object(obj: Pickable)
signal dropped_object(obj: Pickable)

@export var objectHoldPoint: Node2D
@export var objectDropPoint: Node2D

var currentHoldedObject: Pickable

func start_holding(obj: Pickable) -> void:
	if currentHoldedObject != null:
		print(name, " can't pick up object. Already holding one!")
		return
	
	print(owner.name, " is picking up ", obj.name)
	currentHoldedObject = obj
	
	call_deferred("pick_up", obj)

func drop() -> Pickable:
	if currentHoldedObject == null:
		print(name, " can't drop. Not holding anything!")
		return null
	
	var obj = currentHoldedObject
	
	obj.owner.reparent(get_tree().current_scene)
	move_to_drop_point()
	dropped_object.emit(obj)
	currentHoldedObject = null
	return obj

func move_to_drop_point() -> void:
	if currentHoldedObject == null:
		print(name, " can't move. Not holding anything!")
		return
	
	if objectDropPoint:
		currentHoldedObject.owner.global_position = objectDropPoint.global_position

func take_item(interactor: InteractReceiver):
	if is_holding():
		place(interactor.objectHolder)

func place(objectHolder: ObjectHolder) -> Pickable:
	var obj = drop()
	objectHolder.start_holding(obj)
	return obj

func throw(dir: Vector2) -> Pickable:
	if currentHoldedObject == null:
		print(name, " can't throw. Not holding anything!")
		return
	
	var obj = drop()
	obj.throw(dir)
	
	return obj

func pick_up(obj: Pickable):
	obj.be_picked_up(self) # Don't like calling this here
	obj.owner.reparent(objectHoldPoint)
	obj.owner.position = Vector2.ZERO
	obj.owner.rotation = 0
	picked_up_object.emit(currentHoldedObject)

func is_holding() -> bool:
	return currentHoldedObject != null;
