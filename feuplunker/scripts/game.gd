extends Node2D
var currentPlayerExams = {}
@onready var ui = $Player/Camera2D/CanvasLayer/Ui
var gameOver = preload("res://scenes/game_over.tscn")
var victory = preload("res://scenes/victory.tscn")
var run_time = 0.0
var running = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_timer()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if running:
		run_time += delta

func start_timer():
	run_time = 0.0
	running = true

func stop_timer():
	running = false

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
	stop_timer()
	var final_time = run_time
	
	ui.queue_free()
	
	var canvas = $Player/Camera2D/CanvasLayer
	
	var victoryNode = victory.instantiate()
	
	var finalScore = calculate_score()
	if finalScore < 9.5:
		victoryNode.set_score_value(str(finalScore).pad_decimals(1))
		victoryNode.set_victory_status("You Failed!!")
	else:
		victoryNode.set_score_value(str(finalScore).pad_decimals(1))
		victoryNode.set_victory_status("You Passed!!")
	
	victoryNode.set_timer_value(str(final_time).pad_decimals(1) + " seconds")
	
	canvas.add_child(victoryNode)
	get_child(1).game_over()
