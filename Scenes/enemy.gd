extends CharacterBody3D

@onready var nav_agent = $NavigationAgent3D
var SPEED = 3.0
var health = 100
var root_node

func _ready():
	root_node = get_parent()

func update_target_location (target_location):
	nav_agent.set_target_position(target_location)
	

func _physics_process(delta):
	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	
	var player_pos = root_node.get_node("player").global_position
	
	look_at(player_pos) # Enemy will turn to face player
	
	# Vector Maths
	var new_velocity = (player_pos-current_location).normalized() * SPEED

	velocity = new_velocity
	
	move_and_slide()
