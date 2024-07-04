extends PanelContainer

signal recipeSelected(id)

var canCraft = false
var recipe := {}
var itemId := "":
	set(value):
		recipe = Items.recipes[value]
		itemId = value
		$TextureRect.texture = load("res://assets/items/"+value+".png")

func _ready():
	setState()

func setState():
	if canCraft:
		return
	self_modulate = Color.RED

func _on_button_pressed():
	recipeSelected.emit(itemId)
