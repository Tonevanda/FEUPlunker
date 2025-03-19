extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func set_score_value(score):
	$"Score/Score Value".text = score

func set_timer_value(time):
	$"Time/Time Value".text = time
