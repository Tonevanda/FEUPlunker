extends Node2D
var examName: String
var examValue
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Needed to add call_deferred to this only runs after the parent node has selected the exams
	call_deferred("_select_own_name")
	call_deferred("_define_own_value")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_area_2d_body_entered(_body: Node2D) -> void:
	if is_inside_tree():
		get_tree().get_root().get_child(0).exam_found(examName, examValue)
		queue_free()

func _define_own_value():
	examValue = get_parent().get_exam_value()
	$Label.text = str(examValue)

# Selects a name for itself taking account the selected names by the parent node
func _select_own_name():
	var parent = get_parent()
	if parent and parent.has_method("get_exam_name"):
		var selectedName = parent.get_exam_name()
		examName = selectedName
	else:
		print("Error: Parent node does not have a valid exam name method")
		
