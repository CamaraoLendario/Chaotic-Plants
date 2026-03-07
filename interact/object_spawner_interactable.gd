extends Interactable

@export var spawnScene: PackedScene
@export var objectHolder: ObjectHolder

func interact(interactor: Character) -> void:
	if objectHolder.is_holding():
		var otherObjectHolder: ObjectHolder = interactor.objectHolder
		objectHolder.place(otherObjectHolder)
	else:
		var spawn = spawnScene.instantiate()
		add_child(spawn)
		objectHolder.start_holding(spawn.get_node("Pickable"))
