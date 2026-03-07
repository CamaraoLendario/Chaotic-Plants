extends AnimatedSprite2D

@export var character: Character

func _ready() -> void:
	play("Idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var lookingLeft : bool = character.wishDir.x < 0
	
	if (character.velocity.length() < character.maxSpeed*0.05 and character.wishDir == Vector2.ZERO):
		play("Idle")
	## TODO: Decide if this is necessary, cold also just be a turning animation
	#elif (character.wishDir.x * character.velocity.x < 0):
		#play("ChangingMoveDir")
		#lookingLeft = !lookingLeft
	else:
		play("Moving")
	
	flip_h = lookingLeft
