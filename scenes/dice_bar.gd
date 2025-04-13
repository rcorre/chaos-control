extends HBoxContainer

func _ready() -> void:
	add_die(4)
	add_die(6)
	add_die(8)

func add_die(sides: int) -> void:
	var button := Button.new()
	add_child(button)
	button.text = str(sides)
	button.toggle_mode = true
	button.add_theme_font_size_override("font_size", 32)
	button.focus_mode = Control.FOCUS_NONE

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("roll"):
		roll()

func roll() -> void:
	for c in get_children():
		var b := c as Button
		if (b and b.button_pressed):
			roll_die(b)

func roll_die(b: Button) -> void:
	var sides := b.text.to_int()
	prints("Rolling", sides)
	var label := Label.new()
	b.add_child(label)
	var score := randi_range(1, sides)
	label.text = str(score)
	var tween := get_tree().create_tween()
	tween.tween_property(label, "position", Vector2(0, -100), 0.5).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	b.set_pressed_no_signal(false)
	b.release_focus()
