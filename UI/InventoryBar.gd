extends HBoxContainer

const ICON_OFFSET = 20

# Centers the inventory bar at the bottom of the viewport
func _ready():
	var view_size = get_viewport().size
	self.margin_left = -view_size.x / 2
	self.margin_right = view_size.x / 2
	self.margin_top = view_size.y - ICON_OFFSET
	self.margin_bottom = -ICON_OFFSET
	#start_add()
	
	
func start_add():
	while(true):
		var button = Button.new()
		button.icon = load("res://assets/icon.png")
		self.add_child(button)
		var t = Timer.new()
		t.set_wait_time(3)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		t.queue_free()
	
func _on_item_added(new_button):
	self.add_child(new_button)