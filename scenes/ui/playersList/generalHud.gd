extends Control

func _ready():
	makePlayerList()
	Multihelper.player_registered.connect(makePlayerList)
	Multihelper.player_despawned.connect(makePlayerList)
	Multihelper.player_score_updated.connect(makePlayerList)

func makePlayerList():
	for c in %playerList.get_children():
		c.queue_free()
	for player in Multihelper.spawnedPlayers.keys():
		var playerSlotScene := preload("res://scenes/ui/playersList/player_slot.tscn")
		var playerSlot := playerSlotScene.instantiate()
		%playerList.add_child(playerSlot)
		playerSlot.playerId = player
