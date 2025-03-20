extends Node2D
@onready var timer = $Timer

# This is ordered by the year the course is taken 
var possibleExamNames = [
		"AMAT I", "FPRO", "FSC", "MDIS", "ALGA", 			# Y1S1
		"AMAT II", "ACOM", "FÍSICA I", "PROG", "TCOM",		# Y1S2
		"AED", "BD", "FÍSICA II", "LDTS", "SO",				# Y2S1
		"DA", "ESOF", "LCOM", "LTW", "MEST",				# Y2S2
		"FSI", "IPC", "LBAW", "PFL", "RCOM",				# Y3S1
		"COMP", "CGRA", "CPD", "IA",	 					# Y3S2
	]

var selectedExams = []
var examValues = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	select_random_exams()
	#print(selectedExams)
	generate_exam_values()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func generate_exam_values():
	for i in range(selectedExams.size()):
		var value = snappedf(randf_range(5.0, 10.0), 0.1)
		examValues.append(value)
	

# Selects 4 random exams from the exam pool
# Stores it in the selectedExams array with 8 elements, since the 4 selected exams are duplicated to form pairs
func select_random_exams():
	var availableIndices = range(possibleExamNames.size())

	while(selectedExams.size() < 4):
		var index = availableIndices.pop_at(randi() % availableIndices.size())
		selectedExams.append(possibleExamNames[index])
	
	var dupe = selectedExams.duplicate()
	selectedExams.append_array(dupe)
	
	selectedExams.shuffle()

func get_exam_value():
	examValues.shuffle()
	return examValues.pop_back()

func get_exam_name():
	if selectedExams.size() > 0:
		# Removes and retuns name from list
		return selectedExams.pop_at(randi() % selectedExams.size())
	return "KEY_UNKNOWN"

#Called by the magnifying glass powerup
func display_values():
	for N in self.get_children():
		if N is not Timer:
			N.get_node("Label").visible = true
	timer.start(30)


func _on_timer_timeout() -> void:
	for N in self.get_children():
		if N is not Timer:
			N.get_node("Label").visible = false
	timer.stop()
