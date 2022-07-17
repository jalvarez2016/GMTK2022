extends Control

onready var turnManager = load("res://UI/TurnManager.gd").new()
onready var uiInfo = $UICanvas/UI/Info
onready var buttons = $UICanvas/UI/Buttons

#Math functions
var rng = RandomNumberGenerator.new()
func chooseEnemyMath(array):
	rng.randomize()
	var enemy = array[rng.randi_range(0, array.size() - 1)]
	return enemy
	
#Gameplay logic

func _ready():
	# Add logic to assign turn to whoever is the fastest
	match turnManager.turn:
		turnManager.ALLY_TURN:
			uiInfo.text = "It is the Babies turn"
		turnManager.ENEMY_TURN:
			uiInfo.text = "It is the enemies turn"
	buttons = buttons.get_children();
	turnManager.connect("ally_turn_started", self, "_on_EndTurn_ally_turn_started")
	turnManager.connect("enemy_turn_started", self, "_on_EndTurn_enemy_turn_started")
	
func _on_EndTurn_enemy_turn_started():
	uiInfo.text = "It is the enemies turn"
	print('enemy turn started')
	# Hint: Look in the PlayerManager for how to randomly generate a number
	# Randomly pick a player
	# Randomly decide on damage value
	# Lower health of that player //use a signal to call a dfferent script
	
	# put the enemies turn on a timer
	#turnManager.turn = turnManager.ALLY_TURN # Uncomment this when other enemy logic has been implemented
	pass # Replace with function body.
	
#Quality of life function for ending player and enemy turns	
	
func end_player_turn():
	for button in buttons:
		button.disabled = true
	turnManager.turn = turnManager.ENEMY_TURN
	
func end_enemy_turn():
	for button in buttons:
		button.disabled = false
	turnManager.turn = turnManager.ALLY_TURN
	
	
#Friend turn logic

func _on_EndTurn_ally_turn_started():
	for button in buttons:
		button.disabled = false
	print("ally turn started")
	
	
# Button Logic

func _on_Attack_pressed():
	print('attacking')
	var enemies = get_tree().get_nodes_in_group("Enemy");
	print(enemies)
	var enemy = chooseEnemyMath(enemies)
	enemy.get_children()[2].value -= 10
	#end_player_turn()
	
func _on_Ultimate_pressed():
	print("ultimating")
	
	#end_player_turn()

func _on_EndTurn_pressed():
	print('endturn button pressed')
	end_player_turn()

