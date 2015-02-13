extends "res://scripts/unit_control.gd"

const action_attack = 0
const action_move   = 1
const action_capture = 2

var ap_cost_modifier = 4
var path_size_modifier = 8
var action_type_modifiers = [1, 1, 2, 1, 1, 1]
var capture_modifiers = [5, 2, 2]
var attack_modifiers = [2, 3, 4]
var move_capture_modifiers = [5, 2, 3]
var move_attack_modifiers = [1, 2, 5]

const ACTION_ATTACK = 0
const ACTION_MOVE   = 1
const ACTION_CAPTURE = 2
const ACTION_SPAWN = 3
const ACTION_MOVE_TO_ATTACK = 4
const ACTION_MOVE_TO_CAPTURE = 5

func estimate_action(action_type, path_size, ap_cost):
	var modifier = 1
	if action_type == ACTION_CAPTURE:
		modifier = capture_modifiers[type]
	elif action_type == ACTION_ATTACK:
		modifier = attack_modifiers[type]
	elif action_type == ACTION_MOVE_TO_ATTACK:
		modifier = move_attack_modifiers[type]
	elif action_type == ACTION_MOVE_TO_CAPTURE:
		modifier = move_capture_modifiers[type]

	var score = 50 * modifier
	score = score * action_type_modifiers[action_type]
	score = score - ap_cost_modifier * ap_cost
	score = score - path_size_modifier * path_size

	return score

func can_capture():
	return false

func can_attack_unit_type(defender):
	if type == 1 && defender.type == 2:
		return false

	return true




