extends Resource
class_name PlantRequest

signal requestFulfilled()

@export_range(0, 1, 0.001) var requestTime: float

@export_range(0, 1, 0.001) var requestDuration: float

@export var plantData: PlantData
