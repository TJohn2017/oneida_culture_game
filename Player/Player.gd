# This script controls the movement of the player sprite.
extends KinematicBody2D

# The directions that the player can face
enum DIRECTIONS{
	left,
	right,
	forward,
	backward
}

# Constant movement variables
const MOVEMENT_SPEED = 400
# The vector storing the body's movement data.
var motion = Vector2.ZERO
# Stores the direction that the player is currently facing
var direction = DIRECTIONS.forward
# The currently playing animation
var current_animation = ""
# The next animation to be played
var next_animation = "IdleForward"
# The player's inventory of tools and seeds.
onready var inventory = $Inventory
# The class containing all possible objects
const Items = preload("res://Objects/Item.gd")

# TESTING VAR
var can_add = true
	
# Adds an inventory button when pressed, used for testing
func _process(delta):
	if Input.is_key_pressed(KEY_A) and can_add:
		#can_add = false
		var new_obj = Items.new()
		new_obj.type = Items.OBJECT_TYPES.CORN
		new_obj.icon_path = "res://assets/icon.png"
		inventory.add_item(new_obj)
		#delay_add(1)
	
# Delays the addition of another inventory button	
func delay_add(time):
	var t = Timer.new()
	t.set_wait_time(time)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
	can_add = true

# Updates the movement of the player based on input every tick
# and sets the current animation of the player character.
func _physics_process(delta):
	var axis = get_input_axis()
	if axis == Vector2.ZERO:
		motion = Vector2.ZERO
	else:
		apply_movement(axis * MOVEMENT_SPEED)
	motion = move_and_slide(motion)
	# Handle animations
	set_player_movement_animation(axis)
	if current_animation != next_animation:
		current_animation = next_animation
		$AnimatedSprite.play(current_animation)		
		
# Sets the appropriate player animation
func set_player_movement_animation(axis):
	if axis == Vector2.ZERO:
		if direction == DIRECTIONS.left:
			next_animation = "IdleLeft"
		elif direction == DIRECTIONS.right:
			next_animation = "IdleRight"
		else:
			next_animation = "IdleForward"
	else:
		if axis.y > 0:
			next_animation = "RunningDown"
			direction = DIRECTIONS.forward
		elif axis.y < 0:
			next_animation = "RunningDown"
			direction = DIRECTIONS.backward
		if axis.x > 0:
			next_animation = "RunningRight"
			direction = DIRECTIONS.right
		elif axis.x < 0:
			next_animation = "RunningLeft"
			direction = DIRECTIONS.left
	
# Gets the direction of hte user's input
func get_input_axis():
	var axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	axis.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return axis.normalized()

# When the user is providing input apply movement to the body
func apply_movement(acceleration):
	motion += acceleration
	motion = motion.clamped(MOVEMENT_SPEED)