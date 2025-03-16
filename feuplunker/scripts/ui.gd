extends Control
@onready var healthBar = $HealthBar
@onready var energyBar = $EnergyBar
const HEALTH_DECAY = 1
const ENERGY_DECAY = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	energyBar.value -= ENERGY_DECAY
	
func damage():
	healthBar.value -= HEALTH_DECAY

func update_energy(value):
	energyBar.value += value

func get_energy():
	return energyBar.value
