extends GutTest

func _result() -> ClashResult:
	var r := ClashResult.new()
	r.winner = 0
	r.rounds.append({"power_a": 8, "power_b": 5, "lit_a": [true, false], "lit_b": [false], "sparks_a": 2, "sparks_b": 0})
	r.hits.append(4)
	r.hits.append(6)
	return r

func _types(steps: Array[Dictionary]) -> Array:
	return steps.map(func(s): return s["type"])

func test_ordem_dos_passos() -> void:
	var steps := ClashTimeline.build(_result())
	assert_eq(_types(steps), ["round", "spark", "spark", "spark", "resolve", "winner", "hit", "hit"])

func test_faiscas() -> void:
	var steps := ClashTimeline.build(_result())
	assert_eq(steps[2]["lit"], false)
	assert_eq(steps[3]["side"], 1)

func test_perdedor_da_rodada() -> void:
	var steps := ClashTimeline.build(_result())
	assert_eq(steps[4]["loser"], 1)

func test_golpes() -> void:
	var steps := ClashTimeline.build(_result())
	assert_eq(steps[7]["damage"], 6)
	assert_eq(steps[7]["index"], 1)

func test_sem_rodadas() -> void:
	var r := ClashResult.new()
	r.winner = 1
	r.hits.append(3)
	assert_eq(_types(ClashTimeline.build(r)), ["winner", "hit"])

func test_empate_na_rodada() -> void:
	var r := ClashResult.new()
	r.rounds.append({"power_a": 5, "power_b": 5, "lit_a": [], "lit_b": [], "sparks_a": 1, "sparks_b": 1})
	var steps := ClashTimeline.build(r)
	assert_eq(steps[1]["loser"], -1)
