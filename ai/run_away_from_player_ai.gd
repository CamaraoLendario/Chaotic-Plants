extends Node
class_name RunawayAI

@export var minDistanceToPlayer = 100
@export var rotationDegreesVariance = 15
@export_range(0, 1, 0.001) var wallAvoidance = 0.2

@export_group("References")
@export var character: Character
@export var wallChecker: RayCast2D

var minDistanceToPlayerSquared

var player: Node2D

var goalDir: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	minDistanceToPlayerSquared = minDistanceToPlayer*minDistanceToPlayer
	player = get_tree().get_first_node_in_group("Player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if player.global_position.distance_squared_to(owner.global_position) < minDistanceToPlayerSquared:
		run_away(delta)
	else:
		character.wishDir = Vector2.ZERO

func run_away(delta: float) -> void:
	var baseDir = player.global_position.direction_to(owner.global_position)
	var rotation = deg_to_rad(randf_range(-rotationDegreesVariance, rotationDegreesVariance))
	goalDir = goalDir.move_toward(baseDir.rotated(rotation), delta)
	
	wallChecker.global_rotation = goalDir.angle()
	if wallChecker.is_colliding():
		var normal = wallChecker.get_collision_normal()
		goalDir = goalDir * (1 - wallAvoidance) + normal * wallAvoidance
		
	character.wishDir = goalDir.normalized()

func is_close_to_wall() -> bool:
	return wallChecker.is_colliding()

func disable():
	print("strawberry has been disabled")
	character.wishDir = Vector2.ZERO
	process_mode = Node.PROCESS_MODE_DISABLED

func enable():
	print("strawberry has been enabled")
	process_mode = Node.PROCESS_MODE_INHERIT
