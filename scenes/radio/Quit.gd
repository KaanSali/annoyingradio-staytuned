extends TextureButton

signal quit_requested

func _on_pressed():
	emit_signal("quit_requested")
