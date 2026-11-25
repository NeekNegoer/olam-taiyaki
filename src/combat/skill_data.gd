class_name SkillData
extends Resource

enum Stone {RED, YELLOW, WHITE, BLACK}

@export var id: StringName
@export var display_name: String
@export var base_power: int
@export var sparks: int
@export var spark_bonus: int
@export var stone: Stone

static func make(p_id: StringName, p_base_power: int, p_sparks: int, p_spark_bonus: int, p_stone: Stone) -> SkillData:
	var s := SkillData.new()
	s.id = p_id
	s.base_power = p_base_power
	s.sparks = p_sparks
	s.spark_bonus = p_spark_bonus
	s.stone = p_stone
	return s
