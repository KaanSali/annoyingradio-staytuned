extends Control

@export var playButton : TextureButton
@export var scaleRate : float
@onready var animPlayer : AnimationPlayer = $AnimationPlayer
@onready var subwoofer = $Base/Subwoofer_Outer
func _ready():
	if is_instance_valid(playButton):
		playButton.connect("toggled",_on_play_toggled)
func play():
	animPlayer.play("Music On")
	
func stop():
	animPlayer.stop()
	create_tween().tween_property(subwoofer,"scale",Vector2(1,1),0.1)
func set_subwoofer_scale(val:float):
	create_tween().tween_property(subwoofer,"scale",Vector2(val + scaleRate,val + scaleRate),0.1)
	#$Base/Subwoofer_Outer.scale = Vector2(val + scaleRate,val + scaleRate)

func _on_play_toggled(button_pressed):
	if(button_pressed):
		play()
	else:
		stop()
