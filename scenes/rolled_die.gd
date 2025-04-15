extends TextureButton
class_name RolledDie

@onready var die: Node3D = $SubViewport/Die

var sides: int
var value: int # current top side

# rotation required to get to a certain side
func desired_rotation() -> Vector3:
	match value:
		1:
			return Vector3(0, PI, 0)
		2:
			return Vector3(0, PI/2, 0)
		3:
			return Vector3(PI/2, 0, 0)
		4:
			return Vector3(-PI/2, 0, 0)
		5:
			return Vector3(0, -PI/2, 0)
		6:
			return Vector3(0, 0, 0)

	assert(false, "Unhandled side/value pair in desired_rotation: %d / %d" % [value, sides])
	return Vector3.ZERO

func roll() -> void:
	prints("Rolling", sides, "to", value)
	var tween := get_tree().create_tween()
	tween.set_parallel()
	tween.tween_property(self, "position", Vector2(0, -100), 0.5).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	var rot := desired_rotation()
	tween.tween_property(die, "rotation", rot, 0.5).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	self.focus_mode = FOCUS_NONE

func _pressed() -> void:
	Events.control_earned.emit(-1)
	value = (value + 1) % sides

func remove() -> void:
	var tween := get_tree().create_tween()
	tween.tween_property(self, "modulate", Color.TRANSPARENT, 2.0).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_callback(queue_free)
