extends HBoxContainer

const ICON_OFFSET = 20

# Centers the inventory bar at the bottom of the viewport
func _ready():
	var view_size = get_viewport().size
	self.margin_left = -view_size.x / 2
	self.margin_right = view_size.x / 2
	self.margin_top = view_size.y - ICON_OFFSET
	self.margin_bottom = -ICON_OFFSET
	
func _on_item_added(new_button):
	self.add_child(new_button)