extends Node

var money := 0
var control := 0

func _ready() -> void:
	Events.money_earned.connect(on_money_earned)
	Events.control_earned.connect(on_control_earned)
	Events.request_die_purchase.connect(on_die_purchase_requested)
	Events.request_die_rotate.connect(on_die_rotate_requested)

func on_die_purchase_requested(sides: int, cost: int):
	if money >= cost:
		money -= cost
		Events.money_changed.emit(money)
		Events.add_die.emit(sides)

func on_money_earned(amount: int):
	money += amount
	Events.money_changed.emit(money)

func on_control_earned(amount: int):
	control += amount
	Events.control_changed.emit(control)

func on_die_rotate_requested(die: RolledDie, value: int) -> void:
	if control > 0:
		die.change_side_to(value)
		control -= 1
		Events.control_changed.emit(control)
