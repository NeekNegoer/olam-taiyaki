extends GutTest

func _rng(s: int) -> RandomNumberGenerator:
	var r := RandomNumberGenerator.new()
	r.seed = s
	return r

func test_mais_faiscas_e_poder_vence_quase_sempre() -> void:
	var a := SkillData.make(&"a", 10, 3, 3, SkillData.Stone.RED)
	var b := SkillData.make(&"b", 1, 1, 1, SkillData.Stone.RED)
	var wins := 0
	for s in 50:
		if Clash.resolve(a, 0, b, 0, _rng(s)).winner == 0:
			wins += 1
	assert_gte(wins, 48)

func test_zero_faiscas_perde_sem_rodadas() -> void:
	var a := SkillData.make(&"a", 5, 3, 1, SkillData.Stone.RED)
	var b := SkillData.make(&"b", 5, 0, 1, SkillData.Stone.RED)
	var r := Clash.resolve(a, 0, b, 0, _rng(1))
	assert_eq(r.winner, 0)
	assert_eq(r.rounds.size(), 0)
	assert_eq(r.hits.size(), 3)

func test_golpes_igual_faiscas_restantes() -> void:
	var a := SkillData.make(&"a", 4, 3, 2, SkillData.Stone.RED)
	var b := SkillData.make(&"b", 4, 3, 2, SkillData.Stone.RED)
	var r := Clash.resolve(a, 0, b, 0, _rng(7))
	var last: Dictionary = r.rounds[-1]
	var left: int = last["sparks_a"] if r.winner == 0 else last["sparks_b"]
	assert_eq(r.hits.size(), left)

func test_mesma_semente_mesmo_resultado() -> void:
	var a := SkillData.make(&"a", 4, 3, 2, SkillData.Stone.RED)
	var b := SkillData.make(&"b", 3, 4, 1, SkillData.Stone.YELLOW)
	var r1 := Clash.resolve(a, 2, b, -1, _rng(7))
	var r2 := Clash.resolve(a, 2, b, -1, _rng(7))
	assert_eq(r1.winner, r2.winner)
	assert_eq(r1.rounds, r2.rounds)
	assert_eq(r1.hits, r2.hits)

func test_empate_eterno_termina() -> void:
	var x := SkillData.make(&"x", 5, 2, 0, SkillData.Stone.RED)
	var r := Clash.resolve(x, 0, x, 0, _rng(3))
	assert_eq(r.rounds.size(), 100)
	assert_eq(r.winner, 0)
