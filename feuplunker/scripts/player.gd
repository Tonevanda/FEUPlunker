extends CharacterBody2D

var SPEED = 130.0
const JUMP_VELOCITY = -360.0
const DOWN_ATTACK_SPEED = 50
@onready var animationTree = get_node("AnimationTree")
@onready var ui = $Camera2D/CanvasLayer/Ui
var gameOver  = preload("res://scenes/game_over.tscn")
var isGameOver = false
var direction
var health = 3
var knockback = Vector2.ZERO

# Coyote time (jump buffer) variables:
var coyote_time := 0.15       # Maximum time (in seconds) allowed after leaving the ground to still jump.
var coyote_timer := 0.0      # Timer that counts down when off the ground.
var jumped := false


func _ready() -> void:
	animationTree.active = true
	pass
	
func _physics_process(delta: float) -> void:
		
	# Check if game is over, so player can't control anything
	if isGameOver:
		return
	
	# Check if energy has run out, in that case it's game over
	if ui.get_energy() <= 0:
		get_parent().end_game()
	
	direction = Input.get_axis("move_left", "move_right")
	
	# Update coyote timer:
	if is_on_floor():
		stop_animation("Jumping")
		stop_animation("airSword")
		coyote_timer = coyote_time   # Reset timer when on the floor.
		jumped = false
	else:
		coyote_timer -= delta        # Count down when in the air.
		if Input.is_action_just_pressed("sword"):
			play_animation("airSword")
			velocity += get_gravity() * delta * DOWN_ATTACK_SPEED
	
	# Apply gravity:
	velocity += get_gravity() * delta
	
	if Input.is_action_just_pressed("jump") and coyote_timer > 0:
		ui.update_energy(-100)
		velocity.y = JUMP_VELOCITY
		play_animation("Jumping")
		jumped = true
		coyote_timer = 0
		
	if direction != 0:
		x_movement()
		if is_on_floor():
			ui.update_energy(-2)
			stop_animation("Idling")
			play_animation("Running")

	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		play_animation("Idling")
		stop_animation("Running")
	
	# Apply knockback
	velocity.x += knockback.x
	velocity.y += knockback.y
	knockback.x = move_toward(knockback.x, 0, SPEED)
	knockback.y = move_toward(knockback.y, 0, SPEED * 10)
	
	move_and_slide()
	

func x_movement():
	velocity.x = direction * SPEED
	blend_animations()


func _on_area_2d_body_entered(_body: Node2D) -> void:
	health -= 1
	ui.damage() 
	
	if health == 0:
		get_parent().end_game()
	
	if velocity.x != 0:
		knockback.x = -velocity.x * 3
		knockback.y = JUMP_VELOCITY
	else:
		knockback.x = -SPEED * 3
		knockback.y = JUMP_VELOCITY
	
	play_animation("Jumping")
	stop_animation("Idling")
	stop_animation("Running")
	position.x -= 2

#detecs tileset not pickups
func _on_detection_area_body_entered(_body: Node2D) -> void:
		SPEED = 10.0

#detecs tileset not pickups
func _on_detection_area_body_exited(_body: Node2D) -> void:
		SPEED = 150.0

func game_over():
	isGameOver = true
	
func game_restart():
	isGameOver = false

func play_animation(animationName: String):
	var animationPath = "parameters/conditions/%s" % animationName
	animationTree[animationPath] = true

func stop_animation(animationName: String):
	var animationPath = "parameters/conditions/%s" % animationName
	animationTree[animationPath] = false

func blend_animations():
	animationTree["parameters/AirAttackBlend/blend_position"] = direction
	animationTree["parameters/AirAttackLandBlend/blend_position"] = direction
	animationTree["parameters/RunBlend/blend_position"] = direction
	animationTree["parameters/IdleBlend/blend_position"] = direction
	animationTree["parameters/JumpBlend/blend_position"] = direction
	animationTree["parameters/FallBlend/blend_position"] = direction
	animationTree["parameters/LandBlend/blend_position"] = direction
