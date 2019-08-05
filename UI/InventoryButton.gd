extends Button

class_name InventoryButton

# Variables containing info about the associated item
# var has_item = false
var contained_item: Node

# prepares button for interaction
func _ready():
	var err = connect("pressed", self, "equip_item")
	if err != 0:
		print("Could not connect inventory button to item equip")

# When the button has been pressed equip the item associated with
# the button if one does exist
func equip_item():
	#if has_item:
	print("would have equipped item")
		
# Sets the item that is associated with the button
func set_item(item):
	contained_item = item
	#has_item = true