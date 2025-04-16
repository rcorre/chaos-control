extends TextureButton
class_name RolledDie

@onready var die: Node3D = $SubViewport/Die

# starting at the top, moving clockwise
var ADJACENT_SIDES := {
	1: [3, 2, 4, 5],
	2: [3, 6, 4, 1],
	3: [1, 5, 6, 2],
	4: [6, 5, 1, 2],
	5: [3, 1, 4, 6],
	6: [3, 5, 4, 2],
}

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
	tween.tween_interval(1.0)
	tween.finished.connect(add_chaos_buttons)

func remove() -> void:
	var tween := get_tree().create_tween()
	tween.tween_property(self, "modulate", Color.TRANSPARENT, 1.0).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_callback(queue_free)

func add_chaos_buttons() -> void:
	var angle := 0.0
	for val in ADJACENT_SIDES[value]:
		var button := Button.new()
		button.text = str(val)
		add_child(button)
		button.position = size / 2.0 - button.size / 2.0 + (Vector2.UP * 32).rotated(angle)
		angle += PI / 2.0
		button.pressed.connect(func(): Events.request_die_rotate.emit(self, val as int))

func change_side_to(val: int) -> void:
	var tween := get_tree().create_tween()
	value = val
	var rot := desired_rotation()
	tween.tween_property(die, "rotation", rot, 0.5).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	for c in get_children():
		if c is Button:
			c.queue_free()
