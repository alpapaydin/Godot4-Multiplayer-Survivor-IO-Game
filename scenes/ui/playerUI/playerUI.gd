extends Control

func setPlayerName(newName:String):
	%nameLabel.text = newName
	resizeNameToFit()

func setHPBarRatio(ratio):
	%hpBar.value = ratio

func resizeNameToFit():
	var fontSize = 14
	while %nameLabel.get_line_count() > 1:
		fontSize -= 1
		%nameLabel.set("theme_override_font_sizes/font_size", fontSize)
