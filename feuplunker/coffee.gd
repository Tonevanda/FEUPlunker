extends Node2D
@onready var ui = get_node("/root/Game/Player/Camera2D/Ui")
const ENERGY_REPLETED = 1000

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if is_inside_tree():
		ui.update_energy(ENERGY_REPLETED)
		queue_free()
