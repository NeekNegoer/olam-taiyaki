extends GutTest

func test_make_preenche_campos() -> void:
	var s:= SkillData.make(&"golpe", 4, 3, 2, SkillData.Stone.RED)
	assert_eq(s.id, &"golpe")
	assert_eq(s.base_power, 4)
	assert_eq(s.sparks, 3)
	assert_eq(s.spark_bonus, 2)
	assert_eq(s.stone, SkillData.Stone.RED)
