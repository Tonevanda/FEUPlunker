extends Node2D
var currentPlayerExams = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func exam_found(examName, examValue):
	currentPlayerExams[examName] = currentPlayerExams.get(examName, 0) + examValue
	print(currentPlayerExams)
