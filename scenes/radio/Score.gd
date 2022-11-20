extends Label

var time_alive := 0
@onready var timer : Timer = $Timer

func StartTimeAlive():
	timer.start()

func ResetTimeAlive():
	time_alive = 0
	timer.stop()


func _on_timer_timeout():
	time_alive += 1
	text = "Time Alive : %02d:%02d" % [time_alive/60,time_alive%60]


func _on_radio_game_played():
	StartTimeAlive()


func _on_radio_game_stopped():
	ResetTimeAlive()
