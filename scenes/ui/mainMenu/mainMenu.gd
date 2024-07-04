extends Control

func _ready():
	if OS.has_feature("dedicated_server"):
		Multihelper.create_game()

func server_offline():
	$connectTimer.start()

func _on_hostDebugButton_pressed():
	Multihelper.create_game()

func _on_connect_timer_timeout():
	Multihelper.join_game()
