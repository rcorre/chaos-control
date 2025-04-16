extends Control

func _ready() -> void:
	Events.request_die_rotate.connect(on_die_rotate_requested)
	for i in $D6.get_child_count():
		var d := $D6.get_child(i).get_child(0) as RolledDie
		if not d:
			continue
		d.value = i + 1
		d.sides = 6
		d.roll()

func on_die_rotate_requested(die: RolledDie, value: int) -> void:
	die.change_side_to(value)
