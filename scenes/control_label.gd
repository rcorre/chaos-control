extends Label

func _ready() -> void:
	Events.control_changed.connect(on_control_changed)

func on_control_changed(total: int):
	text = "%d" % total

