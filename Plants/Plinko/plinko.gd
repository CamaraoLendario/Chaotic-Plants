@tool
extends Plant
class_name Plinko

@export_tool_button("ResetBall", "ArrowRight") var resetBall: Callable = func():
	plinkoBall.position = plinkoBallSpawnPoint.position
@export_tool_button("NextStage", "ArrowRight") var animateNext: Callable = animateNextDropStage
@export var timeToFall: float = 1
@export_group("Nodes")
@export var plinkoBallSpawnPoint: Marker2D
@export var plinkoBall: Sprite2D
var plinkoBallInitialPosition

var isBallDropping

func on_interacted(interactor: Node2D):
	if interactor is not Character:
		return
	
	tryDropBall()

func tryDropBall() -> bool:
	if (isBallDropping): return false
	
	plinkoBall.position = plinkoBallSpawnPoint.position
	return true

func animateNextDropStage():
	var tween: Tween = create_tween()
	var initialPos = plinkoBall.position
	var direction: int = (randi_range(0, 1) * 2) - 1
	
	tween.tween_method(func(time):
		animateDrop(time, initialPos, direction)
	, 0.0, 1.0, timeToFall)

func animateDrop(time: float, initialPos: Vector2, direction: int = 1):
	plinkoBall.position.y = initialPos.y + 100 + (sin((time+0.5) * PI * (1/1.5)) * (1/(sin(0.5 * PI * (1/1.5)))) * -100)
	plinkoBall.position.x = initialPos.x + time * 100 * direction
