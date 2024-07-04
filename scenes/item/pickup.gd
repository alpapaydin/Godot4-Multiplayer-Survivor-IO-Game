extends Area2D

@export var itemId : String:
	set(value):
		$Sprite2D.texture = load("res://assets/items/"+value+".png")
		itemId = value

@export var stackCount := 1

func _on_body_entered(body):
	if multiplayer.is_server() and body.is_in_group("player"):
		queue_free()
		Inventory.addItem(body.name, itemId, stackCount)
