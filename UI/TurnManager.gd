extends Button
class_name TurnManager
enum {ALLY_TURN, ENEMY_TURN}

var turn = ALLY_TURN setget set_turn, get_turn

signal ally_turn_started()
signal enemy_turn_started()

func set_turn(value : int):
	print('button pressed')
	print(value)
	turn = value
	match turn:
		ALLY_TURN: emit_signal("ally_turn_started")
		ENEMY_TURN:
			print('enemy turn selected') 
			emit_signal("enemy_turn_started")

func get_turn():
	return turn
