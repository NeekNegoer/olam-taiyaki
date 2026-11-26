class_name Combatant
extends RefCounted

const AWAKENING_MAX := 100
const AWAKENING_PER_CLASH_WIN := 20
const AWAKENING_LIGHT_COST := 5
const AWAKENING_MIN_LIGHT := -5

var name: String
var max_hp: int
var hp: int
var light: int = 0
var awakening: int = 0


func _init(p_name: String, p_max_hp: int) -> void:
	name = p_name
	max_hp = p_max_hp
	hp = p_max_hp


func add_light(amount: int) -> void:
	light += amount


func gain_awakening(amount: int) -> void:
	awakening = clampi(awakening + amount, 0, AWAKENING_MAX)


func can_awaken() -> bool:
	return awakening == AWAKENING_MAX and (light - AWAKENING_LIGHT_COST >= AWAKENING_MIN_LIGHT)


func awaken() -> bool:
	if not can_awaken():
		return false
	
	awakening = 0
	add_light(-AWAKENING_LIGHT_COST)
	return true


# Adicione esta função para que o combatente saiba receber dano
func take_damage(amount: int) -> void:
	hp = maxi(hp - amount, 0)
