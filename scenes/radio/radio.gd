extends TextureRect

var volume_offset := 0.5
var is_playing := false
var time_playing := 0.0

@onready var volumeAnalog := $BottomPanel_MC/HBoxContainer/VBoxContainer/BottomPanel_HBox/MarginContainer/ReferenceRect/Volume
@onready var frequency_bar :FrequencyBar= $TopPanel_MC/TopPanel_HBox/Frequency_bar
@onready var Song_Name : SongName = $"BottomPanel_MC/HBoxContainer/VBoxContainer/TextureRect/SongName"
@export var playButton : TextureButton
@export var RadioEffect : AudioStreamPlayer
@export var Music : AudioStreamPlayer 
@export var Songs : Dictionary
@export_node_path(AngerBar) var AngerBarPath
signal game_played
signal game_stopped

func _ready():
	if is_instance_valid(playButton):
		playButton.connect("toggled",PlayRadio)
		volumeAnalog.connect("volume_changed",set_volume_multiplier)
		frequency_bar.connect("frequency_changed",SetSoundVolumes)
	SetRandomTargetFrequency()
	SetSoundVolumes()

func _process(delta):
	if is_playing:
		time_playing += delta
func PlaySound():
	SetSong()
	SetRandomTargetFrequency()
	$TargetFrequencyTimer.start()
	$FrequencySpeedTimer.start()
	$AngerTimer.start()
	Music.play()
	RadioEffect.play()
	is_playing = true
	emit_signal("game_played")
	
func StopSound():
	$TargetFrequencyTimer.stop()
	$FrequencySpeedTimer.stop()
	$AngerTimer.stop()
	get_node(AngerBarPath).Reset()
	frequency_bar.FrequencySpeed = 0.0
	Music.stop()
	RadioEffect.stop()
	ResetPlayingState()
	emit_signal("game_stopped")

func SetSoundVolumes():
	var musicVolume = lerp(0.0,80.0*volume_offset,1.0-frequency_bar.GetFrequencyDistance())
	var radioVolume = lerp(0.0,70.0*volume_offset,frequency_bar.GetFrequencyDistance())
	Music.volume_db = -80.0 + musicVolume
	RadioEffect.volume_db = -80.0 + radioVolume
	
func set_volume_multiplier(value):
	volume_offset = value
	SetSoundVolumes()

func PlayRadio(pressed):
	if pressed:
		PlaySound()
	else:
		StopSound()

func SetRandomTargetFrequency():
	frequency_bar.TargetFrequency = snapped(randf_range(87.5,108.0),0.1)

func SetSong():
	var musicIdx = randi_range(0,Songs.size()-1)
	Music.stream = Songs.values()[musicIdx]
	Music.play()
	Song_Name.SetSongName(Songs.keys()[musicIdx])
	$SongNameTimer.start()

func ResetPlayingState():
	time_playing = 0.0
	is_playing = false
	$SongNameTimer.stop()

func _on_target_frequency_timer_timeout():
	#SetRandomTargetFrequency()
	pass


func _on_anger_timer_timeout():
	var distance = frequency_bar.GetFrequencyDistance()
	var difficulty_scale = floori(time_playing/30.0)
	var angerValue = remap(distance,0.0,1.0,-3.0,4.0*(1.0+difficulty_scale/8.0))
	var anger : AngerBar = get_node(AngerBarPath)
	anger.AddAnger(angerValue)
	if(anger.GetAnger()>=100.0):
		playButton.button_pressed = false
