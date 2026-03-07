extends Interactable
class_name ObjectSpawner

signal spawnedObject(obj: Node2D)

@export var spawnScene: PackedScene
@export var objectHolder: ObjectHolder

func interact(interactor: InteractReceiver) -> void:
	if can_spawn():
		spawn()
	else:
		var otherObjectHolder: ObjectHolder = interactor.objectHolder
		objectHolder.place(otherObjectHolder)

func spawn(sceneToSpawn: PackedScene = spawnScene):
	var spawn = sceneToSpawn.instantiate()
	add_child(spawn)
	objectHolder.start_holding(spawn.get_node("Pickable"))
	
	spawnedObject.emit(spawn)

func can_spawn() -> bool:
	return !objectHolder.is_holding()
