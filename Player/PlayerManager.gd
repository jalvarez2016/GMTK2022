extends StaticBody2D

onready var health = $ProgressBar

export(int) var PlayerHealth = 1
export(int) var PlayerAttack = 1
export(int) var PlayerDefense = 1
export(int) var PlayerSpeed = 1
export(int) var PlayerMagicPoints = 1

var rng = RandomNumberGenerator.new()

func roll_dice(maxValue):
	rng.randomize()
	var newValue = rng.randi_range(1,6) + maxValue
	return newValue


# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerHealth += roll_dice(6)
	PlayerAttack += roll_dice(6)
	PlayerDefense += roll_dice(6)
	PlayerSpeed += roll_dice(6)
	PlayerMagicPoints += roll_dice(6)

func loseHealth(newValue):
	health.value -= newValue
