extends HBoxContainer

const ROLLED_DIE_SCENE: PackedScene = preload("res://scenes/rolled_die.tscn")

@onready var roll_confirm_button: Button = %RollConfirmButton
@onready var roll_sound: AudioStreamPlayer = $RollSound

var rolled_dice: Array[RolledDie]

func _ready() -> void:
	add_die(4)
	add_die(6)
	add_die(8)

	roll_confirm_button.pressed.connect(on_roll_confirm_pressed)

func dice_active() -> bool:
	return not rolled_dice.is_empty()

func on_roll_confirm_pressed():
	if dice_active():
		confirm()
	else:
		roll()

func add_die(sides: int) -> void:
	var button := Button.new()
	add_child(button)
	button.text = str(sides)
	button.toggle_mode = true
	button.add_theme_font_size_override("font_size", 32)
	button.focus_mode = FOCUS_NONE
	Events.dice_active.connect(button.set_disabled)

func _unhandled_input(event: InputEvent) -> void:
	prints(event)
	if rolled_dice.is_empty() and event.is_action_pressed("roll"):
		roll()
	elif not rolled_dice.is_empty() and event.is_action_pressed("confirm"):
		confirm()

func dice() -> Array[Button]:
	var res: Array[Button]
	for c in get_children():
		var b := c as Button
		if b:
			res.push_back(b)
	return res

func roll() -> void:
	roll_confirm_button.text = "Confirm (SPACE)"
	for d in dice():
		if (d and d.button_pressed):
			roll_die(d)

func confirm() -> void:
	roll_confirm_button.text = "Roll (SPACE)"
	var control := dice().size() - rolled_dice.size()
	Events.control_earned.emit(control)

	var money := 0
	for d in rolled_dice:
		money += d.value
		d.remove()
	prints("Scored", money)
	Events.money_earned.emit(money)
	rolled_dice.clear()
	Events.dice_active.emit(false)

func roll_die(b: Button) -> void:
	var die := ROLLED_DIE_SCENE.instantiate() as RolledDie
	rolled_dice.push_back(die)
	die.sides = b.text.to_int()

	b.add_child(die)
	b.set_pressed_no_signal(false)
	b.release_focus()

	roll_sound.play()
	Events.dice_active.emit(true)
