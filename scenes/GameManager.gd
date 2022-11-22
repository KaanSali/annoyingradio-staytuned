extends Control
@onready var animPlayer : AnimationPlayer = $AnimationPlayer
@onready var radioClick : AudioStreamPlayer = $RadioClick
@onready var quit = $Radio_Margin_Container/HBoxContainer/Radio/BottomPanel_MC/HBoxContainer/VBoxContainer/BottomPanel_HBox/Quit
func _ready():
	quit.connect("quit_requested",QuitGame)
func PlayGame():
	animPlayer.play("Squirrel Play")
	radioClick.play()
func StopGame():
	animPlayer.play("Squirrel Stop")
	radioClick.play()	
func QuitGame():
	radioClick.play()
	animPlayer.play("Squirrel Quit")
func Quit():
	get_tree().quit()

func _on_radio_game_stopped():
	StopGame()


func _on_radio_game_played():
	PlayGame()
