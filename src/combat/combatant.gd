class_name Combatant
extends RefCounted

const LIGHT_CLASH_WIN := 1
const LIGHT_CLASH_LOSS := -1
const LIGHT_ALLY_DOWN := -2
const LIGHT_NIGHT_START := -3

const AWAKENING_MAX := 100
const AWAKENING_PER_CLASH_WIN := 20
const AWAKENING_LIGHT_COST := 5
const AWAKENING_MIN_LIGHT := -5

var display_name: String
var max_hp: int
var hp: int
var light: int = 0
var awakening: int = 0
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

func gain_awakening(amount: int) -> void:
	awakening = clampi(awakening + amount, 0, AWAKENING_MAX)

func can_awaken() -> bool:
	return awakening == AWAKENING_MAX and light - AWAKENING_LIGHT_COST >= AWAKENING_MIN_LIGHT

func awaken() -> bool:
	if not can_awaken():
		return false
	awakening = 0
	add_light(-AWAKENING_LIGHT_COST)
	return true
