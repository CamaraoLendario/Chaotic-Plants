extends Node2D
class_name ObjectSpawner

signal spawnedObject(obj: Node2D)

@export var spawnScene: PackedScene
@export var objectHolder: ObjectHolder
@export var interactable: Interactable

func _ready() -> void:
	interactable.interactionStarted.connect(
		func (_interactor): if can_spawn(): spawn())

func spawn(sceneToSpawn: PackedScene = spawnScene):
	var spawn = sceneToSpawn.instantiate()
	add_child(spawn)
	objectHolder.hold_object(spawn.get_node("Pickable"))
	
	spawnedObject.emit(spawn)

func can_spawn() -> bool:
	return !objectHolder.is_holding()
