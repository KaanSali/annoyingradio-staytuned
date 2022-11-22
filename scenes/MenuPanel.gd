extends Panel

func _on_tutorial_button_pressed():
	show()
	$Tutorial.show()
	$Credits.hide()
	

func _on_credits_button_pressed():
	show()
	$Tutorial.hide()
	$Credits.show()

func _on_quit_button_pressed():
	hide()
