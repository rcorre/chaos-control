extends Label

func _ready() -> void:
	Events.money_changed.connect(on_money_changed)
	pivot_offset = size / 2.0

func on_money_changed(total: int):
	text = "$%d" % total

	var tween := get_tree().create_tween()

	scale = Vector2.ONE * 1.5
	tween.tween_property(self, "scale", Vector2(1.0, 1.0), 1.0).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

	modulate = Color.YELLOW
	tween.tween_property(self, "modulate", Color.WHITE, 1.0).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
