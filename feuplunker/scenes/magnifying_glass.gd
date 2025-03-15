extends Node2D
@onready var exams = get_node("/root/Game/Level/Exams")
@onready var timer = Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_area_2d_body_entered(_body: Node2D) -> void:
	if is_inside_tree():
		exams.display_values()
		queue_free()
