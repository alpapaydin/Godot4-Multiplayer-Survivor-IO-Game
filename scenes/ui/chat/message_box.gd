extends PanelContainer

@export var text : String:
	set(value):
		text = value
		$Label.text = value
		resizeNameToFit()
		appearAnimation()
	
func resizeNameToFit():
	var fontSize = 32
	while $Label.get_line_count() > 2:
		fontSize -= 1
		$Label.set("theme_override_font_sizes/font_size", fontSize)

func appearAnimation():
	var tween = create_tween()
	var curPos = position
	var movePos = Vector2(0, -100)
	tween.tween_property(self, "position", curPos + movePos, 2)
	tween.tween_callback(destroyMessage)
	tween.parallel().tween_property(self, "scale", Vector2(0,0), 2)
	tween.parallel().tween_property(self, "modulate", Color.TRANSPARENT, 2)

func destroyMessage():
	if multiplayer.is_server():
		queue_free()
