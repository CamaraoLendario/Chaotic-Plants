extends Plant
class_name Plinko

func on_interacted(interactor: Node2D):
	if interactor is not CharacterBody2D: ##TODO: change "CharacterBody2D" to the player class
		return
	
