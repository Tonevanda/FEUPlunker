extends Node2D
var currentPlayerExams = {}
@onready var ui = $Player/Camera2D/CanvasLayer/Ui
var gameOver = preload("res://scenes/game_over.tscn")
var victory = preload("res://scenes/victory.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func exam_found(examName, examValue):
	currentPlayerExams[examName] = currentPlayerExams.get(examName, 0) + examValue

func calculate_score():
	if currentPlayerExams.size() == 0:
		return 0
	else:
		return currentPlayerExams.values().reduce(func(x, y): return x + y, 0) / float(currentPlayerExams.size())

func end_game():
	ui.queue_free()
	
	var canvas = $Player/Camera2D/CanvasLayer
	canvas.add_child(gameOver.instantiate())

func win_game():
	ui.queue_free()
	
	var canvas = $Player/Camera2D/CanvasLayer
	var victoryNode = victory.instantiate()
	victoryNode.get_child(2).get_child(0).text = str(calculate_score()).pad_decimals(1)
	canvas.add_child(victoryNode)
	get_child(1).game_over()
