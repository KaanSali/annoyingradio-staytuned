extends TextureJumpButton

@export_node_path(Control) var FrequencyNodePath
@export_range(0.1,1.0,0.1) var FrequencyStep := 0.1
@export var IsNegative : bool = false
@export var FrequencyTimerTickRate : float = 0.2
@onready var Frequencybar : FrequencyBar

var isHeldDown : bool = false
var FrequencyTimer : float  = 0.0
func _ready():
	Frequencybar = get_node_or_null(FrequencyNodePath)
	
func _physics_process(delta):
	if not isHeldDown:
		FrequencyTimer = 0.0
		return
	if(FrequencyTimer < FrequencyTimerTickRate):
		FrequencyTimer += delta
		return
	if is_instance_valid(Frequencybar):
		if IsNegative:
			Frequencybar.Frequency -= FrequencyStep
		else:
			Frequencybar.Frequency += FrequencyStep
		FrequencyTimer = 0.0
	
func _on_button_down():
	isHeldDown = true;

func _on_button_up():
	isHeldDown = false;
