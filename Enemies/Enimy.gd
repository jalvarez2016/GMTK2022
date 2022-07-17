extends StaticBody2D

onready var health = $ProgressBar
export(int) var EnemieHealth = 1
export(int) var EnemieAttack = 1
export(int) var EnemieDefense = 1
export(int) var EnemieSpeed = 1
export(int) var EnemieMagicPoints = 1
export(int) var whoTOAttack = 0
var rng = RandomNumberGenerator.new()

func roll_dice(maxValue):
	rng.randomize()
	var newValue = rng.randi_range(1,maxValue) 
	return newValue

func Attacking():
	var _attacking = roll_dice(3)
	
	EnemieHealth += roll_dice(6)
	EnemieAttack += roll_dice(6)
	EnemieDefense += roll_dice(6)
	EnemieSpeed += roll_dice(6)
	EnemieMagicPoints += roll_dice(6)
	var friends = get_tree().get_nodes_in_group('friends')
	friends[rng.randi_range(0,1) ].get_children()[2].value -= roll_dice(100)
# Called when the node enters the scene tree for the first time.
func _ready():
	Attacking()

