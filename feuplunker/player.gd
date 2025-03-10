extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -300.0
@export var downAttackSpeed = 50
@onready var animationPlayer = get_node("AnimationPlayer")
@onready var animationTree = get_node("AnimationTree")
@onready var ui = $Camera2D/Ui
var direction
var health = 3
var knockback = Vector2.ZERO

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
			ui.update_energy(-100)
			velocity.y = JUMP_VELOCITY
			animationTree["parameters/conditions/Jumping"] = true
			animationTree["parameters/conditions/Idling"] = false
			animationTree["parameters/conditions/Running"] = false
		elif direction:
			ui.update_energy(-2)
			x_movement()
			animationTree["parameters/conditions/Idling"] = false
			animationTree["parameters/conditions/Running"] = true
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			animationTree["parameters/conditions/Idling"] = true
			animationTree["parameters/conditions/Running"] = false
	velocity.x += knockback.x
	velocity.y += knockback.y
	knockback.x = move_toward(knockback.x, 0, SPEED*10)
	knockback.y = move_toward(knockback.y, 0,SPEED*10)
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




func _on_area_2d_body_entered(body: Node2D) -> void:
	health -= 1
	ui.damage() 
	if velocity.x != 0:
		knockback.x = -velocity.x * 2
		knockback.y = JUMP_VELOCITY
	else:
		knockback.x = -SPEED * 2
		knockback.y = JUMP_VELOCITY
	animationTree["parameters/conditions/Jumping"] = true
	animationTree["parameters/conditions/Idling"] = false
	animationTree["parameters/conditions/Running"] = false
	position.x -= 2
	if health == 0:
		queue_free()
