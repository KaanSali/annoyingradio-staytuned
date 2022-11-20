extends TextureButton
class_name TextureJumpButton
@export var depressButtons : Array[NodePath]
@export var pressButtons : Array[NodePath]
func _pressed():
	for path in pressButtons:
		get_node(path).button_pressed = true
	
func _toggled(pressed):
	if is_hovered():
		if not pressed:
			button_pressed = true
		for path in depressButtons:
			get_node(path).button_pressed = false
# Called when the node enters the scene tree for the first time.
