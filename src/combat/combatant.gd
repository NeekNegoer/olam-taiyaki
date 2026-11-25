class_name Combatant
extends RefCounted

const LIGHT_CLASH_WIN := 1
const LIGHT_CLASH_LOSS := -1
const LIGHT_ALLY_DOWN := -2
const LIGHT_NIGHT_START := -3

var display_name: String
var max_hp: int
var hp: int
var light: int = 0
var skills: Array[SkillData]

func _init(p_name: String, p_max_hp: int, p_skills: Array[SkillData] = []) -> void:
	display_name = p_name
	max_hp = p_max_hp
	hp = p_max_hp
	skills = p_skills

func add_light(amount: int) -> void:
	light = clampi(light + amount, Sparks.LIGHT_MIN, Sparks.LIGHT_MAX)

func take_damage(amount: int) -> void:
	hp = maxi(hp - amount, 0)

func is_down() -> bool:
	return hp == 0

func is_panicking() -> bool:
	return light == Sparks.LIGHT_MIN
