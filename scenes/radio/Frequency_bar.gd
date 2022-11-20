extends TextureRect
class_name FrequencyBar
@export_category("Frequency Values")
@export var FrequencyContainer : MarginContainer
@export var TargetFrequencyContainer : MarginContainer
@export_range(87.5,108.0,0.1) var Frequency : float = 87.5 : set = SetCurrentFrequency
@export_range(87.5,108.0,0.1) var TargetFrequency : float = 92.5 : set = SetTargetFrequency
@export_category("InitialValues")
@export_range(0.0,0.1) var FrequencySpeed : float = 0.0
@export_range(0.0,0.1,0.01) var FrequencyMaxSpeed : float = 0.09


signal frequency_changed

var RandomFrequencyTimer : float  = 0.0


func _ready():
	SetCurrentFrequency(Frequency)
	SetTargetFrequency(TargetFrequency)

func _physics_process(delta):
	if(RandomFrequencyTimer < 0.01):
		RandomFrequencyTimer += delta
		return
	#SetCurrentFrequency(Frequency+FrequencySpeed)
	SetTargetFrequency(TargetFrequency+FrequencySpeed)
	RandomFrequencyTimer = 0.0

func SetCurrentFrequency(value):
	value = clamp(value,87.5,108.0)
	Frequency = value
	var remapValue = remap(value,87.5,108.0,16.0,436.0)
	if(is_instance_valid(FrequencyContainer)):
		FrequencyContainer.add_theme_constant_override("margin_left",remapValue)
	emit_signal("frequency_changed")

func SetTargetFrequency(value):
	value = clamp(value,87.5,108.0)	
	TargetFrequency = value
	var remapValue = remap(value,87.5,108.0,16.0,436.0)
	if(is_instance_valid(TargetFrequencyContainer)):
		TargetFrequencyContainer.add_theme_constant_override("margin_left",remapValue)
	emit_signal("frequency_changed")
	
func GetFrequencyDistance()->float:
	var FrequencyMix = remap(clamp(abs(TargetFrequency-Frequency),0.0,1.5),0.0,1.5,0.0,1.0)
	return FrequencyMix

func SetRandomFrequencySpeed():
	FrequencySpeed = snapped(randf_range(-FrequencyMaxSpeed,FrequencyMaxSpeed),0.01)
	if(TargetFrequency == 87.5):
		FrequencySpeed = abs(FrequencySpeed)
	elif(TargetFrequency == 108.0):
		FrequencySpeed = -abs(FrequencySpeed)
