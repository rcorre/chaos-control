extends Node

var money := 0
var control := 0

func _ready() -> void:
	Events.money_earned.connect(on_money_earned)
	Events.control_earned.connect(on_control_earned)

func on_money_earned(amount: int):
	money += amount
	Events.money_changed.emit(money)

func on_control_earned(amount: int):
	control += amount
	Events.control_changed.emit(control)
