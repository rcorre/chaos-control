extends TextureButton

@onready var anim: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	toggle_mode = true

func _pressed() -> void:
	if button_pressed:
		prints("play")
		anim.play("active")
	else:
		prints("reset")
		anim.play("RESET")
