extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@export var downAttackSpeed = 50
@onready var animationPlayer = get_node("AnimationPlayer")
@onready var animationTree = get_node("AnimationTree")
var direction

func _ready() -> void:
	animationTree.active = true
	pass
	
func _physics_process(delta: float) -> void:
	direction = Input.get_axis("move_left", "move_right")
	# Add the gravity.
	if not is_on_floor():
		animationTree["parameters/conditions/Jumping"] = false
		velocity += get_gravity() * delta
		if direction:
			x_movement()
		if Input.is_action_just_pressed("sword"):
			animationTree["parameters/conditions/airSword"] = true
			velocity += get_gravity() * delta * downAttackSpeed
	else:
		animationTree["parameters/conditions/Jumping"] = false
		animationTree["parameters/conditions/airSword"] = false
		# Handle jump.
		if Input.is_action_just_pressed("jump"):
			velocity.y = JUMP_VELOCITY
			animationTree["parameters/conditions/Jumping"] = true
			animationTree["parameters/conditions/Idling"] = false
			animationTree["parameters/conditions/Running"] = false
		elif direction:
			
			x_movement()
			animationTree["parameters/conditions/Idling"] = false
			animationTree["parameters/conditions/Running"] = true
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			animationTree["parameters/conditions/Idling"] = true
			animationTree["parameters/conditions/Running"] = false
		
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
