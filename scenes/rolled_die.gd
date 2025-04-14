extends Button
class_name RolledDie

var sides: int
var value: int # current top side

func _ready() -> void:
	prints("Rolling", sides)
	value = randi_range(1, sides)
	text = str(value)
	var tween := get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(0, -100), 0.5).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	self.focus_mode = FOCUS_NONE

func _pressed() -> void:
	Events.control_earned.emit(-1)
	value = (value + 1) % sides
	text = str(value)

func remove() -> void:
	var tween := get_tree().create_tween()
	tween.tween_property(self, "modulate", Color.TRANSPARENT, 2.0).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_callback(queue_free)
