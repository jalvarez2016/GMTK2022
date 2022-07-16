extends Control

onready var turnManager = load("res://UI/TurnManager.gd").new()
onready var uiInfo = $UICanvas/UI/Info

func _ready():
	# Add logic to assign turn to whoever is the fastest
	match turnManager.turn:
		turnManager.ALLY_TURN:
			uiInfo.text = "It is the Babies turn"
		turnManager.ENEMY_TURN:
			uiInfo.text = "It is the enemies turn"
	turnManager.connect("ally_turn_started", self, "_on_EndTurn_ally_turn_started")
	turnManager.connect("enemy_turn_started", self, "_on_EndTurn_enemy_turn_started")
	
func on_ally_turn_started():
	pass
	# Write the player turn logic here
	# Show UI
	# Add turnManager.turn = ENEMY_TURN to end of any attack/UI action
	turnManager.turn = turnManager.ENEMY_TURN

func _on_EndTurn_enemy_turn_started():
	print('enemy turn started')
	# Hint: Look in the PlayerManager for how to randomly generate a number
	# Randomly pick a player
	# Randomly decide on damage value
	# Lower health of that player //use a signal to call a dfferent script
	
	# put the enemies turn on a timer
	#turnManager.turn = turnManager.ALLY_TURN # Uncomment this when other enemy logic has been implemented
	pass # Replace with function body.


func _on_EndTurn_ally_turn_started():
	print("ally turn started")
	pass # Replace with function body.

func _on_EndTurn_pressed():
	print('endturn button pressed')
	turnManager.turn = turnManager.ENEMY_TURN
	pass # Replace with function body.
