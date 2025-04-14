extends Button

@export var sides := 4
@export var cost := 10

func _ready() -> void:
	text = "%d ($%d)" % [sides, cost]
	focus_mode = FOCUS_NONE
	disabled = true
	Events.money_changed.connect(on_money_changed)

func on_money_changed(amount: int):
	disabled = cost > amount

func _pressed() -> void:
	Events.request_die_purchase.emit(sides, cost)
