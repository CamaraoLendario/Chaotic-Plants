extends Area2D
class_name Pickable

signal WasPickedUp(picker: Picker)
signal WasDropped(picker: Picker)

func can_be_picked() -> bool:
	return true

func get_picked(picker: Picker):
	WasPickedUp.emit(picker)

func get_dropped(picker: Picker):
	WasDropped.emit(picker)


func activate():
	monitoring = true
	monitorable = true

func deactivate():
	monitoring = false
	monitorable = false
