extends TextureButton
class_name DieButton

@onready var anim: AnimationPlayer = $AnimationPlayer

var sides: int

func _ready() -> void:
	toggle_mode = true
	add_theme_font_size_override("font_size", 48)
	focus_mode = FOCUS_NONE
	Events.dice_active.connect(on_dice_active)

func on_dice_active(active: bool) -> void:
	disabled = active
	if not active:
		self_modulate = Color.WHITE
		button_pressed = false
	elif button_pressed:
		self_modulate = Color.TRANSPARENT

func _toggled(on: bool) -> void:
	if on:
		anim.play("active")
	else:
		anim.play("RESET")
