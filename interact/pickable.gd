extends Interactable
class_name Pickable

signal WasPickedUp
signal WasDropped

var isBeingHeld: bool = false
var curObjectHolder: ObjectHolder

func interact(interactor: InteractReceiver) -> void:
	if !can_be_interacted():
		return
	
	var objectHolder: ObjectHolder = interactor.objectHolder
	if objectHolder:
		objectHolder.start_holding(self)
		
	super.interact(interactor)

func be_picked_up(objectHolder: ObjectHolder) -> void:
	isBeingHeld = true
	curObjectHolder = objectHolder
	objectHolder.dropped_object.connect(_on_was_dropped)
	
	WasPickedUp.emit()

func throw(dir: Vector2):
	if owner is RigidBody2D:
		owner.apply_central_impulse(dir)
	else:
		print("Owner must be rigid body for this object to be thrown!")
		return

func _on_was_dropped(_obj: Node2D):
	curObjectHolder.dropped_object.disconnect(_on_was_dropped)
	curObjectHolder = null
	isBeingHeld = false
	
	WasDropped.emit()

func can_be_interacted() -> bool:
	return !isBeingHeld
