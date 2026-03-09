extends ObjectSpawner

@export var plantData: PlantData

@export var seedScene: PackedScene

	
func spawn(sceneToSpawn: PackedScene = seedScene):
	var seedSpawn: Seed = sceneToSpawn.instantiate()
	add_child(seedSpawn)
	seedSpawn.set_data(plantData)
	objectHolder.hold_object(seedSpawn.get_node("Pickable"))
	
	spawnedObject.emit(spawn)
