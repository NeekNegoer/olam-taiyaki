extends GutTest

func test_luz_limitada() -> void:
	var c := Combatant.new("Ben", 20)
	c.add_light(50)
	assert_eq(c.light, 10)
	c.add_light(-50)
	assert_eq(c.light, -10)

func test_dano_nao_negativo() -> void:
	var c := Combatant.new("Ben", 20)
	c.take_damage(25)
	assert_eq(c.hp, 0)
	assert_true(c.is_down())

func test_panico_so_no_minimo() -> void:
	var c := Combatant.new("Ben", 20)
	c.add_light(-9)
	assert_false(c.is_panicking())
	c.add_light(-1)
	assert_true(c.is_panicking())
