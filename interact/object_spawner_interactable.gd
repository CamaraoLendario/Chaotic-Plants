extends Interactable

@export var spawnScene: PackedScene
@export var objectHolder: ObjectHolder

@warning_ignore("unused_parameter")
func interact(interactor: Node2D) -> void:
	if objectHolder.is_holding():
		var otherObjectHolder: ObjectHolder = interactor.get_node("ObjectHolder")
		objectHolder.place(otherObjectHolder)
	else:
		var spawn: Pickable = spawnScene.instantiate()
		add_child(spawn)
		objectHolder.start_holding(spawn)
