extends Button

signal roll
signal confirm

var dice_active := false

func _ready() -> void:
	Events.dice_active.connect(on_dice_active)

func on_dice_active(active: bool):
	dice_active = active
	if active:
		text = "Confirm (SPACE)"
	else:
		text = "Roll (SPACE)"

func _pressed() -> void:
	if dice_active:
		confirm.emit()
	else:
		roll.emit()
