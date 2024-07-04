extends Node

signal inventoryUpdated(id)
signal itemRemoved(id, item)
signal updateReceived(id)

var inventories := {}
# {1: {"wood": 5, "iron": 3}}
var durabilities := {}
# {1: {"pickaxe": 95}}

func _ready():
	if !multiplayer.is_server():
		return
	inventoryUpdated.connect(sendToPeer)

func sendToPeer(id):
	if multiplayer.is_server():
		var durabilityData = durabilities[id] if id in durabilities else {}
		setInventory.rpc_id(int(str(id)), id, inventories[id], durabilityData)

@rpc("any_peer", "call_remote", "reliable")
func setInventory(id, data, durabilityData):
	inventories[id] = data
	durabilities[id] = durabilityData
	updateReceived.emit(id)

func checkInventoryExists(id) -> bool:
	if id in inventories:
		return true
	inventories[id] = {}
	return false

func checkHasItem(id, item) -> bool:
	if !checkInventoryExists(id):
		return false
	if item in inventories[id]:
		return true
	return false
	
func checkItemCount(id, item) -> int:
	if !checkHasItem(id, item):
		return 0
	return inventories[id][item]

func checkHasItemAmount(id, item, amount) -> bool:
	var itemCount = checkItemCount(id,item)
	if itemCount >= amount:
		return true
	return false

func addItem(id, item, amount) -> void:
	if checkHasItem(id, item):
		inventories[id][item] += amount
	else: inventories[id][item] = amount
	inventoryUpdated.emit(id)

func removeItem(id, item, amount=1) -> bool:
	var quantity = checkItemCount(id, item)
	if  quantity > amount:
		inventories[id][item] -= amount
		inventoryUpdated.emit(id)
		return true
	elif quantity == amount:
		inventories[id].erase(item)
		inventoryUpdated.emit(id)
		itemRemoved.emit(id, item)
		return true
	return false

func canCraftItem(id, item) -> bool:
	var recipe = Items.recipes[item]
	for ing in recipe.keys():
		if !checkHasItemAmount(str(id), ing, recipe[ing]):
			return false
	return true

func useItemDurability(id, item, durabilityDamage = 1):
	if id not in durabilities:
		durabilities[id] = {}
	if "durability" in Items.equips[item]:
		if item in durabilities[id]:
			durabilities[id][item] -= durabilityDamage
		else:
			durabilities[id][item] = Items.equips[item]["durability"] - durabilityDamage
		if durabilities[id][item] <= 0:
			removeItem(id, item)
			durabilities[id].erase(item)
		else:
			inventoryUpdated.emit(id)

@rpc("any_peer", "call_local", "reliable")
func tryCraftItem(id, item) -> bool:
	if canCraftItem(id, item):
		var recipe = Items.recipes[item]
		for ing in recipe.keys():
			if !removeItem(id, ing, recipe[ing]):
				return false
		addItem(id, item, 1)
		inventoryUpdated.emit(id)
		return true
	return false
