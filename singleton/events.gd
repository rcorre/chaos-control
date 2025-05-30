extends Node

@warning_ignore_start("UNUSED_SIGNAL")

signal money_earned(amount)
signal money_changed(total)

signal control_earned(amount)
signal control_changed(total)

signal round_changed(current, max)

# if true, dice have been rolled
# if false, waiting to roll dice
signal dice_active(active)

signal request_die_purchase(sides, cost)
signal add_die(sides)

signal request_die_rotate(die, value)
