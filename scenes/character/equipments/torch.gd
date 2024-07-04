extends Node2D

@export var data := {}

func _on_durability_timer_timeout():
	Inventory.useItemDurability(data["player"], data["item"])
