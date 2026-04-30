extends CharacterBody3D


var SPEED = 5.0
const JUMP_VELOCITY = 4.5
var mouse_sensitivity = 0.002
var bulletscene = preload("res://Scenes/bullet.tscn")
var bulletspawn
var ammo : int = 5
var player_health = 100




func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	bulletspawn = get_node("Camera3D/bulletspawn")

func _input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)
		$Camera3D.rotate_x(-event.relative.y * mouse_sensitivity)
		$Camera3D.rotation.x = clampf($Camera3D.rotation.x, -deg_to_rad(70), deg_to_rad(70))

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Handle jump.
	if Input.is_action_just_pressed("player_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_pressed("Player_run"):
		SPEED = 10.0
	else:
		SPEED = 5.0
	#if Input.is_action_just_pressed("player_shoot"):
		#shoot()
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func slash():
	if Input.is_action_pressed("player_shoot"):
		if not $Node3D/AnimationPlayer.is.playing("SwordSwing"):
			$Node3D/AnimationPlayer.play("SwordSwing")

#func shoot():
	#handles shooting
	#var bullet = bulletscene.instantiate()
	#get_parent().add_child(bullet)
	#bullet.global_transform = bulletspawn.global_transform
	#bullet.scale= Vector3(0.1, 0.1, 0.1)
	#ammo -= 1
	
