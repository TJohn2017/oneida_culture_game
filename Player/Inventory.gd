extends Node

class_name Inventory

var contents = []

# Used to update the inventory UI
signal new_item
onready var inv_node = get_node("/root/Game/UI/InventoryButtons")
	
func _ready():
	var err = connect("new_item", inv_node, "_on_item_added")
	if err != 0:
		print("Could not connect new_item signal to item adding in inventory bar.")

# Adds an item to the user's inventory
func add_item(item):
	contents.append(item)
	var button = Button.new()
	#button.set_item(item)
	button.icon = load("res://assets/icon.png")
	if inv_node != null:
		emit_signal("new_item", button)
	
	
# Removes an item from the user's inventory
func remove_item(item):
	var index = contents.find(item)
	if index != -1:
		contents.remove(index)
		
# Returns a boolean indicating whether or not the player has a
# given item
func contains_item(item) -> bool:
	return contents.has(item)
	