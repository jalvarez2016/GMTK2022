extends StaticBody2D

onready var animationPlayer = $AnimationPlayer
onready var health = $ProgressBar
var rng = RandomNumberGenerator.new()

export(int) var PlayerHealth = 1
export(int) var PlayerAttack = 1
export(int) var PlayerDefense = 1
export(int) var PlayerSpeed = 1
export(int) var PlayerMagicPoints = 1

func roll_dice(maxValue):
	rng.randomize()
	var newValue = rng.randi_range(1,6) + maxValue
	return newValue

# Called when the node enters the scene tree for the first time.
func _ready():
	animationPlayer.play("Idle")
	PlayerHealth += roll_dice(6)
	PlayerAttack += roll_dice(6)
	PlayerDefense += roll_dice(6)
	PlayerSpeed += roll_dice(6)
	PlayerMagicPoints += roll_dice(6)

func loseHealth(newValue):
	health.value -= newValue
