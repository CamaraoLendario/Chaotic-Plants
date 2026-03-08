@tool
extends Plant
class_name Plinko

@export_tool_button("Drop new ball", "ArrowDown") var dropNewball: Callable = tryDropBall
#@export_tool_button("Next stage", "ArrowRight") var animateNext: Callable = animateNextDropStage
@export var timeToFall: float = 1
@export_group("Nodes")
@export var plinkoBallSpawnPoint: Marker2D
@export var plinkoBall: Sprite2D
@export var markers: Node
var plinkoBallInitialPosition
var currentLayer : int = -1
var currentLevel : int = 0
var layerCount: int = 2

var rewardTable = [ ## I give up, hardcoding this
	[2, 1, 2, 0, 0],
	[2, 1, 1, 2, 0],
	[3, 2, 1, 2, 3]
]

var isBallDropping

func _ready() -> void:
	super._ready()

func on_interacted(interactor: Node2D):
	if interactor.owner is not Character:
		return
	
	tryDropBall()

func tryDropBall() -> bool:
	if (isBallDropping or isGrown): return false
	reset_values()
	plinkoBall.position = plinkoBallSpawnPoint.position
	setupFirstDrop()
	isBallDropping = true
	return true

func setupFirstDrop():
	var tween: Tween = create_tween()
	var initialPos = plinkoBall.position
	tween.finished.connect(setupNextDropStage)
	
	tween.tween_method(func(time):
		animateFirstDrop(time, initialPos)
	, 0.0, 1.0, timeToFall)

func animateFirstDrop(time: float, initialPos: Vector2):
	var finalPos = initialPos
	plinkoBall.position = calculateDropArc(time, initialPos - Vector2(0, 50), finalPos)

func setupNextDropStage():
	if (currentLayer >= layerCount):
		check_plinko_end()
		return
	var tween: Tween = create_tween()
	var initialPos = plinkoBall.position
	var direction: int = randi_range(0, 1)
	currentLayer += 1 
	currentLevel += direction
	var finalPos: Vector2 =  (markers.get_child(currentLayer).get_child(currentLevel) as Marker2D).position
	
	tween.finished.connect(setupNextDropStage)
	
	
	tween.tween_method(func(time):
		animateNextDrop(time, initialPos, finalPos)
	, 0.0, 1.0, timeToFall)

func animateNextDrop(time: float, initialPos: Vector2, finalPos: Vector2):
	plinkoBall.position = calculateDropArc(time, initialPos, finalPos)

func calculateDropArc(time: float, initialPosition: Vector2, finalPosition: Vector2) -> Vector2:
	var dropDistance = finalPosition.y - initialPosition.y
	var lateralDistance = finalPosition.x - initialPosition.x
	
	var newPos: Vector2 = Vector2(
		initialPosition.x + lateralDistance * time,
		finalPosition.y + sin((time+0.5) * PI * (1/1.5)) * (1/(sin(0.5 * PI * (1/1.5)))) * -dropDistance
	)
	
	return newPos

func check_plinko_end():
	grow()
	isBallDropping = false

func reset_values():
	currentLayer = -1
	currentLevel = 0
