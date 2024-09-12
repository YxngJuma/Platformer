extends CharacterBody2D

var enemy_inattack_range= false
var enemy_attack_cooldown=true
var health=100
var player_alive = true
var SPEED = 130.0
const JUMP_VELOCITY = -300.0


#the jump count
var jump_count=0
var max_jumps =2 

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite= $AnimatedSprite2D


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and jump_count < max_jumps:
		velocity.y = JUMP_VELOCITY
		jump_count +1
	# get the input direction: -1,0,1
	var direction = Input.get_axis("move_left", "move_right")
	#Flip the Sprite
	if direction>0:
		animated_sprite.flip_h= false
	elif direction <0:
		animated_sprite.flip_h= true
	#play animations
	if is_on_floor():
			if direction==0:
				animated_sprite.play("Idle")
			else:
				animated_sprite.play("run")
	else:
		animated_sprite.play("jump")

	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	#sprint
	if Input.is_action_just_pressed("sprint"):
		SPEED= 200.0
	if Input.is_action_just_released("sprint"):
		SPEED=130.0