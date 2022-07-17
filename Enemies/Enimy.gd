extends StaticBody2D

onready var health = $ProgressBar

var rng = RandomNumberGenerator.new()

var count = 0

func roll_dice(maxValue):
	rng.randomize()
	var newValue = rng.randi_range(1,maxValue) 
	return newValue

func Attacking():
#	if defens == true:
	var damage = roll_dice(6)
	var friends = get_tree().get_nodes_in_group('friends')
	friends[rng.randi_range(0,1) ].get_children()[2].value -= damage
#		defens = false

# Called when the node enters the scene tree for the first time.
func _ready():
	print('hellow')

func _play_attacked():
	var sound = $AttackedSound
	sound.play()
