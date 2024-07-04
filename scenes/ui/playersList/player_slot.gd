extends HBoxContainer

var data : Dictionary
var playerId : int:
	set(value):
		playerId = value
		data = Multihelper.spawnedPlayers[value]
		$PlayerNameLabel.text = data["name"]
		$PlayerScoreLabel.text = str(data["score"])
		resizeNameToFit($PlayerNameLabel)
		resizeNameToFit($PlayerScoreLabel)

func resizeNameToFit(label):
	var fontSize = 16
	while label.get_line_count() > 1:
		fontSize -= 1
		label.set("theme_override_font_sizes/font_size", fontSize)
