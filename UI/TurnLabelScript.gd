extends Control

onready var turnManager = load("res://UI/TurnManager.gd").new()
onready var uiInfo = $UICanvas/UI/Info
onready var buttons = $UICanvas/UI/Buttons
var friendQueue = []
var currentFriend

#Math functions
var rng = RandomNumberGenerator.new()
func chooseEnemyMath(array):
	rng.randomize()
	var enemy = array[rng.randi_range(0, array.size() - 1)]
	return enemy

class CustomSorter:
	static func sortArrayAscending(a,b):
		print("sorting", a.name, a.PlayerSpeed)
		print("sorting", b.name, b.PlayerSpeed)
		if(a.PlayerSpeed < b.PlayerSpeed):
			return true
		else:
			return false
	
#Gameplay logic

func _ready():
	# Add logic to assign turn to whoever is the fastest
	match turnManager.turn:
		turnManager.ALLY_TURN:
			uiInfo.text = "It is the Babies turn"
		turnManager.ENEMY_TURN:
			uiInfo.text = "It is the Enemies turn"
	buttons = buttons.get_children();
	_on_EndTurn_ally_turn_started()
	turnManager.connect("ally_turn_started", self, "_on_EndTurn_ally_turn_started")
	turnManager.connect("enemy_turn_started", self, "_on_EndTurn_enemy_turn_started")

func end_player_turn():
	if(friendQueue.size() == 0):
		for button in buttons:
			button.disabled = true
		uiInfo.text = "It is the Enemies turn"
		turnManager.turn = turnManager.ENEMY_TURN
	else:
		currentFriend = friendQueue.pop_back()
		_handle_current_player_turn()
	
func end_enemy_turn():
	for button in buttons:
		button.disabled = false
	turnManager.turn = turnManager.ALLY_TURN

func _on_EndTurn_enemy_turn_started():
	print('Enemy turn started')
	# Hint: Look in the PlayerManager for how to randomly generate a number
	# Randomly pick a player
	# Randomly decide on damage value
	# Lower health of that player //use a signal to call a dfferent script
	
	# put the enemies turn on a timer
	end_enemy_turn()
	pass # Replace with function body.
	
func damage_enemy(enemy, value):
	enemy.get_children()[4].playing = true
	enemy.get_children()[2].value -= value
	
#Quality of life function for ending player and enemy turns		
	
#Friend turn logic

func _on_EndTurn_ally_turn_started():
	print('starting overall player turn')
	friendQueue = get_tree().get_nodes_in_group("friends")
	friendQueue.sort_custom(CustomSorter, "sortArrayAscending")
	currentFriend = friendQueue.pop_back()
	_handle_current_player_turn()
	
func _handle_current_player_turn():
	print('handling player turn')
	buttons[0].disabled = false
	buttons[1].disabled = false
	uiInfo.text = 'It is the ' + str(currentFriend.name) + '\'s turn'
	print(currentFriend.name);
	
# Button Logic

func _on_Attack_pressed():
	print('attacking')
	var enemies = get_tree().get_nodes_in_group("Enemy");
	print(enemies)
	var enemy = chooseEnemyMath(enemies)
	damage_enemy(enemy, currentFriend.PlayerAttack)
	buttons[0].disabled = true
	buttons[1].disabled = true
	#end_player_turn()
	
func _on_Ultimate_pressed():
	print("ultimating")
	
	#end_player_turn()

func _on_EndTurn_pressed():
	print('endturn button pressed')
	end_player_turn()

