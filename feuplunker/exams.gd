extends Node2D

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
var examValues = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate_exam_values()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func generate_exam_values():
	select_random_exams()
	
	print(selectedExams)
	
	for exam in selectedExams:
		var examValue = snappedf(randf_range(8.0,10.0), 0.1)
		examValues[exam] = examValue
	

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

func get_exam_value(examName):
	return examValues[examName]

func get_exam_name():
	if selectedExams.size() > 0:
		# Removes and retuns name from list
		return selectedExams.pop_at(randi() % selectedExams.size())
	return "KEY_UNKNOWN"
