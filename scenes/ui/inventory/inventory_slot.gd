extends PanelContainer

signal itemSelected(id)

var pId : int
var index : int
var selected := false
var itemId : String:
	set(value):
		itemId = value
		if value:
			$itemTexture.texture = load("res://assets/items/"+value+".png")
			setItemDurability()
		else:
			$itemTexture.texture = null
			%durabilityBar.visible = false
			$Label.text = ""

var itemCount : int:
	set(value):
		itemCount = value
		$Label.text = "x"+str(value)

func setItemDurability():
	if str(pId) not in Inventory.durabilities:
		return
	var itemDurabilities = Inventory.durabilities[str(pId)]
	if itemId in itemDurabilities:
		%durabilityBar.visible = true
		%durabilityBar.value = itemDurabilities[itemId] / Items.equips[itemId]["durability"]
	else:
		%durabilityBar.visible = false

func selectionChanged(selectedId):
	if selectedId == index:
		selected = true
		$AnimationPlayer.play("selected")
		itemSelected.emit(itemId)
	elif selected:
		selected = false
		$AnimationPlayer.play("deselected")

func setRecipeText(count, needed):
	$Label.text = str(count)+"/"+str(needed)
	if count < needed:
		$bgTexture.modulate = Color.RED
