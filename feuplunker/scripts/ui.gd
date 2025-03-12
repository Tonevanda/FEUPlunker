extends Control
@onready var healthBar = $HealthBar
@onready var energyBar = $EnergyBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	energyBar.value -= 1
	#print(energyBar.value)
	pass
	
func damage():
	healthBar.value -= 1

func update_energy(value):
	energyBar.value += value
