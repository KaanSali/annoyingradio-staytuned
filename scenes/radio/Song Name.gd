extends Label
class_name SongName

var song_name := ""
func SetSongName(song:String)->void:
	song_name = " %s ### " % song
	
func ShiftSongName()->void:
	if not song_name.is_empty():
		song_name = shift_str(song_name)
		text = "Song : %s" % song_name
	
static func shift_str(str:String)->String :
	var firstChar = str.left(1)
	var shifted = str.insert(str.length(),firstChar).trim_prefix(firstChar)
	return shifted


func _on_song_name_timer_timeout():
	ShiftSongName()
