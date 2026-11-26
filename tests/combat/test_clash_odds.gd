extends GutTest

func test_espelho_perto_de_meio() -> void:
	var x := SkillData.make(&"x", 4, 2, 2, SkillData.Stone.RED)
	var c := ClashOdds.win_chance(x, 0, x, 0)
	assert_between(c, 0.40, 0.60)

func test_luz_aumenta_chance() -> void:
	var x := SkillData.make(&"x", 4, 2, 2, SkillData.Stone.RED)
	assert_gt(ClashOdds.win_chance(x, 10, x, -10), 0.85)

func test_estavel() -> void:
	var a := SkillData.make(&"a", 4, 3, 2, SkillData.Stone.RED)
	var b := SkillData.make(&"b", 3, 4, 1, SkillData.Stone.YELLOW)
	assert_eq(ClashOdds.win_chance(a, 2, b, -1), ClashOdds.win_chance(a, 2, b, -1))
