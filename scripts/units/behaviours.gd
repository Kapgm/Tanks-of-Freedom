extends "res://scripts/unit_control.gd"

const action_attack = 0
const action_move   = 1
const action_capture = 2

var ap_cost_modifier = 4
var path_size_modifier = 8
var action_type_modifiers = [1, 1, 2, 1, 2, 1]
var capture_modifiers = [5, 2, 2]
var attack_modifiers = [4, 6, 8]
var move_capture_modifiers = [5, 2, 3]
var move_attack_modifiers = [2, 2, 5]

const ACTION_ATTACK = 0
const ACTION_MOVE   = 1
const ACTION_CAPTURE = 2
const ACTION_SPAWN = 3
const ACTION_MOVE_TO_ATTACK = 4
const ACTION_MOVE_TO_CAPTURE = 5
const HICCUP_MODIFIER = 100
const HI_LIFE_MODIFIER = 15
const LO_LIFE_MODIFIER = -15
const RANDOMNESS_MODIFIER = 20

func estimate_action(action_type, path_size, ap_cost, hiccup):

	var modifier = 1
	var modifier_sign = 1
	if action_type == ACTION_CAPTURE:
		modifier = capture_modifiers[type]
		modifier_sign = -1
	elif action_type == ACTION_ATTACK:
		if attacks_number > 0:
			modifier = attack_modifiers[type]
		else:
			modifier = 1
	elif action_type == ACTION_MOVE_TO_ATTACK:
		if attacks_number > 0:
			modifier = move_attack_modifiers[type]
		else:
			modifier = 1
	elif action_type == ACTION_MOVE_TO_CAPTURE:
		modifier = move_capture_modifiers[type]
		modifier_sign = -1

	# for capturing better is having lo health an so on
	var score = 50 * modifier + (modifier_sign * self._get_health_modifier())
	if hiccup:
		score = score - HICCUP_MODIFIER
		
	score = score * action_type_modifiers[action_type]
	score = score - ap_cost_modifier * ap_cost
	score = score - path_size_modifier * path_size
	score = score + floor(randf() * RANDOMNESS_MODIFIER)

	return score

func _get_health_modifier():
	var status = self.get_life_status();
	if status >= 0.66:
		return HI_LIFE_MODIFIER
	elif status <= 0.33:
		return LO_LIFE_MODIFIER

	return 0

func can_attack_unit_type(defender):
	if type == 1 && defender.type == 2:
		return false

	return true




