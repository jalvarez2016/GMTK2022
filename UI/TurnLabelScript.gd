extends Control

onready var turnManager = load("res://UI/TurnManager.gd").new()
onready var uiInfo = $UICanvas/UI/Info
onready var buttons = $UICanvas/UI/Buttons
var friendQueue = []
var currentFriend
var enemyAttaking = false
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

func on_EndTurn_enemy_turn_started():
	print('Enemy turn started at')
	# Hint: Look in the PlayerManager for how to randomly generate a number
	# Randomly pick a player
	# Randomly decide on damage value
	# Lower health of that player //use a signal to call a dfferent script
	#var Enemy = get_tree().get_nodes_in_group('Enemy')
	#Enemy[0].EnimyAttckingNowc = true
	
	var Enemy = get_tree().get_nodes_in_group('Enemy')
	Enemy[0].Attacking()
	Enemy[0].Attacking()
	Enemy[0].Attacking()
	#.EnimyAttckingNow(2)
	# put the enemies turn on a timer
	ChekIfPlayerLost()
	end_enemy_turn()
	# Replace with function body.
	
func damage_enemy(enemy, value):
	enemy.get_children()[4].play()
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


func PlayerLost():
	get_tree().change_scene("res://WorldStuff/GameOver.tscn")

func ChekIfPlayerLost():
	var friends = get_tree().get_nodes_in_group('friends')
	var CharOne = friends[0].get_children()[2].value
	var CharTwo = friends[0].get_children()[2].value
	var Charthree = friends[0].get_children()[2].value
	if CharOne <= 0 || CharTwo <= 0 || Charthree <= 0:
		 PlayerLost()
