extends GutTest

func test_chance_neutra() -> void:
	assert_almost_eq(Sparks.chance(0), 0.5, 0.0001)

func test_chance_maxima_e_minima() -> void:
	assert_almost_eq(Sparks.chance(10), 0.95, 0.0001)
	assert_almost_eq(Sparks.chance(-10), 0.05, 0.0001)
	assert_almost_eq(Sparks.chance(99), 0.95, 0.0001)
	assert_almost_eq(Sparks.chance(-99), 0.05, 0.0001)

func test_roll_quantidade_e_semente() -> void:
	var a := RandomNumberGenerator.new()
	a.seed = 42
	var b := RandomNumberGenerator.new()
	b.seed = 42
	assert_eq(Sparks.roll(5, 0, a).size(), 5)
	a.seed = 42
	assert_eq(Sparks.roll(5, 0, a), Sparks.roll(5, 0, b))

func test_roll_zero_faiscas() -> void:
	var rng := RandomNumberGenerator.new()
	assert_eq(Sparks.roll(0, 0, rng), [] as Array[bool])
