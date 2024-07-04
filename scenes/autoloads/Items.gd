extends Node

var mobs := {
	"zombie": {"maxhp": 40, "speed": 50, "attack": "slash_attack", "attackDamage": 4, "attackRange": 50, "drops": {"wood": {"min": 1, "max": 2}}},
	"spider": {"maxhp": 80, "speed": 100, "attack": "projectile_attack", "attackDamage": 6, "attackRange": 300, "drops": {"stone": {"min": 1, "max": 2}}},
}

var objects := {
	"tree1": {"id": "tree1", "hp": 40, "tool": "axe", "drops": {"wood": {"min": 1, "max": 2}}},
	"rock1": {"id": "rock1", "hp": 70, "tool": "pickaxe", "drops": {"stone": {"min": 1, "max": 3}}},
	"tree2": {"id": "tree2", "hp": 50, "tool": "axe", "drops": {"wood": {"min": 2, "max": 4}}},
	"rock2": {"id": "rock2", "hp": 100, "tool": "pickaxe", "drops": {"stone": {"min": 2, "max": 5}}},
	"bush1": {"id": "bush1", "hp": 20, "tool": "sword", "drops": {"berries": {"min": 1, "max": 3}}},
	"ore1": {"id": "ore1", "hp": 120, "tool": "pickaxe", "drops": {"iron": {"min": 1, "max": 3}}},
	"tree3": {"id": "tree3", "hp": 60, "tool": "axe", "drops": {"wood": {"min": 3, "max": 5}, "sap": {"min": 1, "max": 1}}},
	"rock3": {"id": "rock3", "hp": 90, "tool": "pickaxe", "drops": {"stone": {"min": 2, "max": 4}, "coal": {"min": 1, "max": 2}}},
	"magicPlant1": {"id": "magicPlant1", "hp": 30, "tool": "sword", "drops": {"magicHerb": {"min": 1, "max": 2}}},
	"crystal1": {"id": "crystal1", "hp": 150, "tool": "pickaxe", "drops": {"crystalShard": {"min": 1, "max": 2}}},
	"magicTree1": {"id": "magicTree1", "hp": 70, "tool": "axe", "drops": {"magicWood": {"min": 1, "max": 3}}},
	"magicRock1": {"id": "magicRock1", "hp": 110, "tool": "pickaxe", "drops": {"magicStone": {"min": 1, "max": 2}}},
}

var equips := {
	"torch": {"attack": "swing", "damage": 20, "damageType": "normal", "durability": 40.0, "scene": "torch"},
	"sword1": {"attack": "swing", "damage": 30, "damageType": "normal", "durability": 5.0},
	"axe1": {"attack": "swing", "damage": 30, "damageType": "axe", "durability": 20.0},
	"pickaxe1": {"attack": "swing", "damage": 30, "damageType": "pickaxe", "durability": 20.0},
	"spear1": {"attack": "stab", "damage": 20, "damageType": "normal", "projectile": "fireshuriken"},
	"dagger1": {"attack": "stab", "damage": 15, "damageType": "normal", "durability": 10.0},
	"axe2": {"attack": "swing", "damage": 40, "damageType": "axe", "durability": 30.0},
	"pickaxe2": {"attack": "swing", "damage": 40, "damageType": "pickaxe", "durability": 30.0},
	"magicSword1": {"attack": "swing", "damage": 35, "damageType": "magic", "durability": 10.0, "projectile": "magicBolt"},
	"magicAxe1": {"attack": "swing", "damage": 45, "damageType": "magic", "durability": 25.0, "projectile": "fireball"},
	"magicDagger1": {"attack": "stab", "damage": 25, "damageType": "magic", "durability": 15.0, "projectile": "iceShard"},
	"magicSpear1": {"attack": "stab", "damage": 30, "damageType": "magic", "durability": 20.0, "projectile": "lightningBolt"},
}

var recipes := {
	"torch": {"wood": 3},
	"sword1": {"wood": 2, "stone": 2},
	"axe1": {"wood": 2, "stone": 3},
	"pickaxe1": {"wood": 2, "stone": 3},
	"spear1": {"wood": 3, "stone": 1},
	"dagger1": {"wood": 1, "stone": 2},
	"axe2": {"wood": 3, "iron": 2},
	"pickaxe2": {"wood": 3, "iron": 2},
	"magicSword1": {"magicWood": 2, "magicStone": 2, "crystalShard": 1},
	"magicAxe1": {"magicWood": 3, "magicStone": 3, "crystalShard": 1},
	"magicDagger1": {"magicWood": 1, "magicStone": 2, "magicHerb": 2},
	"magicSpear1": {"magicWood": 3, "magicStone": 1, "magicHerb": 1},
}

var projectiles := {
	"fireshuriken": {"maxHits": 1, "speed": 50, "time": 1, "curveSpeed": true},
	"icebolt": {"maxHits": 1, "speed": 30, "time": 1.5, "curveSpeed": false, "effect": "freeze"},
	"magicBolt": {"maxHits": 1, "speed": 45, "time": 1.2, "curveSpeed": true, "effect": "magicDamage"},
	"fireball": {"maxHits": 1, "speed": 35, "time": 1.3, "curveSpeed": false, "effect": "burn"},
	"iceShard": {"maxHits": 1, "speed": 40, "time": 1.5, "curveSpeed": false, "effect": "slow"},
	"lightningBolt": {"maxHits": 1, "speed": 50, "time": 1, "curveSpeed": true, "effect": "stun"},
}

func spawnPickups(id, at, amount):
	var pickups := get_node("/root/Game/Level/Main/Pickups")
	for i in range(amount):
		var pickupScene := preload("res://scenes/item/pickup.tscn")
		var pickup := pickupScene.instantiate()
		pickups.call_deferred("add_child", pickup, true)
		pickup.itemId = id
		pickup.position = at + Vector2(randf_range(-15,15), randf_range(-15,15))

func spawnProjectile(spawner, pId, towardsPos, canTarget):
	var projectilesNode := get_node("/root/Game/Level/Main/Projectiles")
	var projectileScene := load("res://scenes/attacks/projectile_attack.tscn")
	var projectile = projectileScene.instantiate()
	projectilesNode.add_child(projectile,true)
	projectile.projectileId = pId
	projectile.targetGroup = canTarget
	projectile.position = spawner.position
	projectile.get_node("MovingParts").rotation = spawner.get_node("MovingParts").rotation
	projectile.hitPlayer.connect(spawner.projectileHit)
	projectile.targetPos = towardsPos
	projectile.spawner = spawner
