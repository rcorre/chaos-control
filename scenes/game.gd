extends Node

const MAX_ROUND := 16

var money := 0
var control := 0
var current_round := 1

func _ready() -> void:
	Events.money_earned.connect(on_money_earned)
	Events.control_earned.connect(on_control_earned)
	Events.request_die_purchase.connect(on_die_purchase_requested)
	Events.request_die_rotate.connect(on_die_rotate_requested)
	Events.dice_active.connect(on_dice_active)

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

func on_dice_active(active: bool):
	if current_round == MAX_ROUND:
		prints("Game ended")
		return
	if !active:
		current_round += 1
		Events.round_changed.emit(current_round, MAX_ROUND)
