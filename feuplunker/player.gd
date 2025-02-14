extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var animationPlayer = get_node("AnimationPlayer")
@onready var animationTree = get_node("AnimationTree")

func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		animationTree.set("parameters/conditions/Running",true)
		animationTree.set("parameters/conditions/Idling",false)
		animationTree["parameters/RunBlend/blend_position"] = direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
		animationTree.set("parameters/conditions/Idling",true)
		animationTree.set("parameters/conditions/Running",false)
		animationTree["parameters/IdleBlend/blend_position"] = 1

	move_and_slide()
