extends CharacterBody2D

var SPEED = 125.0
const JUMP_VELOCITY = -300.0
@export var downAttackSpeed = 50
@onready var animationPlayer = get_node("AnimationPlayer")
@onready var animationTree = get_node("AnimationTree")
@onready var ui = $Camera2D/Ui
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
	direction = Input.get_axis("move_left", "move_right")
	
	# Update coyote timer:
	if is_on_floor():
		animationTree["parameters/conditions/Jumping"] = false
		animationTree["parameters/conditions/airSword"] = false
		coyote_timer = coyote_time   # Reset timer when on the floor.
		jumped = false
	else:
		coyote_timer -= delta        # Count down when in the air.
		if Input.is_action_just_pressed("sword"):
			animationTree["parameters/conditions/airSword"] = true
			velocity += get_gravity() * delta * downAttackSpeed
	
	# Apply gravity:
	velocity += get_gravity() * delta
	
	if Input.is_action_just_pressed("jump") and coyote_timer > 0:
		ui.update_energy(-100)
		velocity.y = JUMP_VELOCITY
		animationTree["parameters/conditions/Jumping"] = true
		jumped = true
		coyote_timer = 0
		
	if direction != 0:
		x_movement()
		if is_on_floor():
			ui.update_energy(-2)
			animationTree["parameters/conditions/Idling"] = false
			animationTree["parameters/conditions/Running"] = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animationTree["parameters/conditions/Idling"] = true
		animationTree["parameters/conditions/Running"] = false
	
	# Apply knockback
	velocity.x += knockback.x
	velocity.y += knockback.y
	knockback.x = move_toward(knockback.x, 0, SPEED)
	knockback.y = move_toward(knockback.y, 0, SPEED * 10)
	
	move_and_slide()
	

func x_movement():
	velocity.x = direction * SPEED
	animationTree["parameters/AirAttackBlend/blend_position"] = direction
	animationTree["parameters/AirAttackLandBlend/blend_position"] = direction
	animationTree["parameters/RunBlend/blend_position"] = direction
	animationTree["parameters/IdleBlend/blend_position"] = direction
	animationTree["parameters/JumpBlend/blend_position"] = direction
	animationTree["parameters/FallBlend/blend_position"] = direction
	animationTree["parameters/LandBlend/blend_position"] = direction


func _on_area_2d_body_entered(_body: Node2D) -> void:
	health -= 0
	ui.damage() 
	if velocity.x != 0:
		knockback.x = -velocity.x * 3
		knockback.y = JUMP_VELOCITY
	else:
		knockback.x = -SPEED * 3
		knockback.y = JUMP_VELOCITY
	animationTree["parameters/conditions/Jumping"] = true
	animationTree["parameters/conditions/Idling"] = false
	animationTree["parameters/conditions/Running"] = false
	position.x -= 2
	if health == 0:
		queue_free()

#detecs tileset not pickups
func _on_detection_area_body_entered(_body: Node2D) -> void:
		SPEED = 10.0

#detecs tileset not pickups
func _on_detection_area_body_exited(_body: Node2D) -> void:
		SPEED = 150.0
