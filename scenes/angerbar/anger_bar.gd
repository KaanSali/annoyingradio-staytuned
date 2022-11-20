extends VBoxContainer

class_name AngerBar

@export_node_path(AnimatedSprite2D) var Avatar
@export var AvatarTypes : Dictionary


func AddAnger(anger):
	create_tween().tween_property($AngerBar,"value",$AngerBar.value+anger,0.3)
	SetAvatar()
func Reset():
	create_tween().tween_property($AngerBar,"value",0,0.3)
	SetAvatar()
func GetAnger()->float:
	return $AngerBar.value
func SetAvatar():
	var avatar : AnimatedSprite2D = get_node(Avatar)
	var divider : int = $AngerBar.max_value/(AvatarTypes.size()) # 25
	var currentAnger :int = GetAnger()/divider #100.0/4 = 25, 100.0 /25 = 4
	avatar.animation = AvatarTypes[min(currentAnger,(AvatarTypes.size()-1))]
