extends Node

@warning_ignore_start("UNUSED_SIGNAL")

signal money_earned(amount)
signal money_changed(total)

signal control_earned(amount)
signal control_changed(total)

# if true, dice have been rolled
# if false, waiting to roll dice
signal dice_active(active)
