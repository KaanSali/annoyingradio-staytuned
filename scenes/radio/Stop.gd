extends TextureButton


@export var toggleButton : Array[NodePath]

func _pressed():
	if is_hovered():
		for path in toggleButton:
			get_node(path).button_pressed = false
# Called when the node enters the scene tree for the first time.
