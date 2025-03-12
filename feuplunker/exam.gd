extends Node2D
@export var examName: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Needed to add call_deferred to this only runs after the parent node has selected the exams
	call_deferred("_select_own_name")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if is_inside_tree():
		var examValue = get_parent().get_exam_value(examName)
		get_tree().get_root().get_child(0).exam_found(examName, examValue)
		queue_free()

# Selects a name for itself taking account the selected names by the parent node
func _select_own_name():
	var parent = get_parent()
	if parent and parent.has_method("get_exam_name"):
		var name = parent.get_exam_name()
		print(name)
		examName = name
	else:
		print("Error: Parent node does not have a valid exam name method")
		
