class_name ObjectHolder extends Node2D

signal picked_up_object(obj: Pickable)
signal dropped_object(obj: Pickable)

@export var objectHoldPoint: Node2D
@export var objectDropPoint: Node2D

var currentHoldedObject: Pickable

func _physics_process(delta: float) -> void:
	if is_holding():
		currentHoldedObject.owner.position = Vector2.ZERO
		currentHoldedObject.owner.rotation = 0

func hold_object(pickable: Pickable): 
	if !is_holding():
		currentHoldedObject = pickable
		currentHoldedObject.WasPickedUp.connect(_on_pickable_was_picked)
		currentHoldedObject.owner.reparent(objectHoldPoint)
		currentHoldedObject.owner.position = Vector2.ZERO
		currentHoldedObject.owner.rotation = 0
		picked_up_object.emit(currentHoldedObject)

func drop_object():
	if is_holding():
		move_to_drop_point()
		currentHoldedObject.WasPickedUp.disconnect(_on_pickable_was_picked)
		currentHoldedObject = null

func drop_and_free():
	if is_holding():
		currentHoldedObject.WasPickedUp.disconnect(_on_pickable_was_picked)
		currentHoldedObject.owner.call_deferred("queue_free")
		currentHoldedObject = null

func move_to_drop_point():
	if objectDropPoint:
		currentHoldedObject.owner.global_position = objectDropPoint.global_position
		currentHoldedObject.owner.reparent(get_tree().current_scene)
	else:
		currentHoldedObject.owner.global_position = objectHoldPoint.global_position
		currentHoldedObject.owner.reparent(get_tree().current_scene)
	picked_up_object.emit(currentHoldedObject)

func _on_pickable_was_picked(_picker):
	dropped_object.emit(currentHoldedObject)
	currentHoldedObject = null

func is_holding():
	return currentHoldedObject != null

#func start_holding(obj: Pickable) -> void:
	#if currentHoldedObject != null:
		#print(name, " can't pick up object. Already holding one!")
		#return
	#
	#print(owner.name, " is picking up ", obj.name)
	#currentHoldedObject = obj
	#
	#call_deferred("pick_up", obj)
#
#
#func drop() -> Pickable:
	#if currentHoldedObject == null:
		#print(name, " can't drop. Not holding anything!")
		#return null
	#
	#var obj = currentHoldedObject
	#
	#obj.owner.reparent(get_tree().current_scene)
	#move_to_drop_point()
	#dropped_object.emit(obj)
	#currentHoldedObject = null
	#return obj
#
#func move_to_drop_point() -> void:
	#if currentHoldedObject == null:
		#print(name, " can't move. Not holding anything!")
		#return
	#
	#if objectDropPoint:
		#currentHoldedObject.owner.global_position = objectDropPoint.global_position
#
#func take_item(interactor: InteractReceiver):
	#if is_holding():
		#place(interactor.objectHolder)
#
#func place(objectHolder: ObjectHolder) -> Pickable:
	#var obj = drop()
	#objectHolder.start_holding(obj)
	#return obj
#
#func throw(dir: Vector2) -> Pickable:
	#if currentHoldedObject == null:
		#print(name, " can't throw. Not holding anything!")
		#return
	#
	#var obj = drop()
	#obj.throw(dir)
	#
	#return obj
#
#func pick_up(obj: Pickable):
	#obj.be_picked_up(self) # Don't like calling this here
	#obj.owner.reparent(objectHoldPoint)
	#obj.owner.position = Vector2.ZERO
	#obj.owner.rotation = 0
	#picked_up_object.emit(currentHoldedObject)
#
#func is_holding() -> bool:
	#return currentHoldedObject != null;
