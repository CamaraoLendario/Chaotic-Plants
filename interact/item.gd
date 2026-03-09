extends RigidBody2D
class_name  ProtoObject

@export var pickable: Pickable

func _ready() -> void:
	pickable.WasPickedUp.connect(_on_was_picked_up)
	pickable.WasDropped.connect(_on_was_dropped)

func _on_was_picked_up(_pickable) -> void:
	set_deferred("freeze", true)


func _on_was_dropped(_pickable) -> void:
	freeze = false
