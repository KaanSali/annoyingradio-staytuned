@tool
extends TextureRect
@export_range(0,180.0) var rotationDegrees : float = 90.0 : 
	set(value):  
		var minValue = min(max(-90.0,value-90.0),90.0)
		rotation = deg_to_rad(minValue)
		rotationDegrees = minValue+90

signal volume_changed(percentage)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		if(event.button_index == MOUSE_BUTTON_WHEEL_DOWN):
			rotationDegrees -= 9
		if(event.button_index == MOUSE_BUTTON_WHEEL_UP):
			rotationDegrees += 9
		emit_signal("volume_changed",rotationDegrees/180.0)
