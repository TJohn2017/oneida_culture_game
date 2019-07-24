# This script controls the movement of the player sprite.
extends KinematicBody2D

# Constant movement variables
const MOVEMENT_SPEED = 400
# The vector storing the body's movement data.
var motion = Vector2.ZERO
# The player's inventory of tools and seeds.
onready var inventory = $Inventory
# The class containing all possible objects
const Items = preload("res://Objects/Item.gd")
	
func _ready():
	var new_obj = Items.new()
	new_obj.type = Items.OBJECT_TYPES.CORN
	new_obj.icon_path = "res://assets/icon.png"
	inventory.add_item(new_obj)

# Updates the movement of the player based on input every tick
# and sets the current animation of the player character.
func _physics_process(delta):
	var axis = get_input_axis()
	if axis == Vector2.ZERO:
		$AnimatedSprite.play("Idle")
		motion = Vector2.ZERO
	else:
		$AnimatedSprite.play("RunningDown")
		apply_movement(axis * MOVEMENT_SPEED)
	motion = move_and_slide(motion)

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