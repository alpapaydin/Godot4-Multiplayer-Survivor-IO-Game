extends Node2D

#objects
const initialSpawnObjects := 10
const maxObjects := Constants.MAX_OBJECTS
const objectWaveCount := 10
var spawnedObjects := 0

#enemies
var enemyTypes := Items.mobs.keys()
const enemyWaveCount := 1
const maxEnemiesPerPlayer := Constants.MAX_ENEMIES_PER_PLAYER
const enemySpawnRadiusMin := 8
const enemySpawnRadiusMax := 9
var spawnedEnemies := {}

func _ready():
	if multiplayer.is_server():
		Multihelper.loadMap()
		spawnObjects(initialSpawnObjects)
		$HUD.queue_free()
	$dayNight.time_tick.connect(%DayNightCycleUI.set_daytime)
	createHUD()

func createHUD():
	var hudScene := preload("res://scenes/ui/playersList/generalHud.tscn")
	var hud := hudScene.instantiate()
	$HUD.add_child(hud)

#object spawn

func spawnObjects(amount):
	var breakableScene := preload("res://scenes/object/breakable.tscn")
	var spawnedThisWave := 0
	for i in range(amount):
		var spawnPos = $Map.tile_map.map_to_local($Map.walkable_tiles.pick_random())
		var breakable := breakableScene.instantiate()
		var objectId = Items.objects.keys().pick_random()
		$Objects.add_child(breakable,true)
		breakable.objectId = objectId
		breakable.position = spawnPos
		breakable.spawner = self
		spawnedObjects += 1
		spawnedThisWave += 1
	return spawnedThisWave

func trySpawnObjectWave():
	if spawnedObjects < maxObjects:
		var toMax := maxObjects - spawnedObjects
		spawnObjects(min(objectWaveCount, toMax))

func _on_object_spawn_timer_timeout():
	if multiplayer.is_server():
		trySpawnObjectWave()

#enemy spawn
func trySpawnEnemies():
	var enemyScene := preload("res://scenes/enemy/enemy.tscn")
	var players = Multihelper.spawnedPlayers.keys()
	for player in players:
		var playerEnemies := getPlayerEnemyCount(player)
		if playerEnemies < maxEnemiesPerPlayer:
			var toSpawn = min(maxEnemiesPerPlayer - playerEnemies, enemyWaveCount)
			var spawnPositions = $NavHelper.getNRandomNavigableTileInPlayerRadius(player, toSpawn, enemySpawnRadiusMin, enemySpawnRadiusMax)
			for pos in spawnPositions:
				var enemy = enemyScene.instantiate()
				$Enemies.add_child(enemy,true)
				enemy.position = pos
				enemy.spawner = self
				enemy.targetPlayerId = player
				enemy.enemyId = enemyTypes.pick_random()
				increasePlayerEnemyCount(player)

func getPlayerEnemyCount(pId) -> int:
	if pId in spawnedEnemies:
		return spawnedEnemies[pId]
	return 0

func increasePlayerEnemyCount(pId) -> void:
	if pId in spawnedEnemies:
		spawnedEnemies[pId] += 1
	else:
		spawnedEnemies[pId] = 1

func decreasePlayerEnemyCount(pId) -> void:
	if pId in spawnedEnemies:
		spawnedEnemies[pId] -= 1
	else:
		spawnedEnemies[pId] = 1

func _on_enemy_spawn_timer_timeout():
	if multiplayer.is_server():
		trySpawnEnemies()
