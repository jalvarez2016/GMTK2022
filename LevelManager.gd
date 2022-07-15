extends Node2D

var turnManager = preload("res://TurnManager.gd")

func _ready():
	turnManager.connect("ally_turn_started", self, "on_ally_turn_strted")
	turnManager.connect("enemy_turn_started", self, "on_enemy_turn_strted")
	pass # Replace with function body.
	
func on_ally_turn_started():
	print('ally turn')
	# Write the player turn logic here
	# Show UI
	# Add turnManager.turn = ENEMY_TURN to end of any attack/UI action
	
func on_enemy_turn_started():
	print('enemy turn')
	# Write the enemy turn logic here
	# Hide UI
	# Enemy act function
	# turnManager.turn = TurnManager.ALLY_TURN
