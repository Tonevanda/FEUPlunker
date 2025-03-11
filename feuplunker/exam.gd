extends Node2D
@export var examType: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if is_inside_tree():
		get_tree().get_root().get_child(0).exam_found("test")
		queue_free()
