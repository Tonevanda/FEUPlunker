extends Control
@onready var healthBar = $HealthBar
@onready var energyBar = $EnergyBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	energyBar.value -= 1
	if(energyBar.value <= 0):
		# Show game over screen
		print("death")
	pass
	
func damage():
	healthBar.value -= 1
	if(healthBar.value <= 0):
		# Show game over screen
		print("fesu")

func update_energy(value):
	energyBar.value += value
