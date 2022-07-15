extends Resource
class_name TurnManager

enum {ALLY_TURN, ENEMY_TURN}

var turn setget set_turn

signal ally_turn_started()
signal enemy_turn_started()

func _ready():
	pass # Replace with function body.

func set_turn(value):
	turn = value
	match turn:
		ALLY_TURN: emit_signal("ally_turn_started")
		ENEMY_TURN: emit_signal("enemy_turn_started")
