extends Label

func _ready() -> void:
	Events.money_changed.connect(on_money_changed)

func on_money_changed(total: int):
	text = "$%d" % total
