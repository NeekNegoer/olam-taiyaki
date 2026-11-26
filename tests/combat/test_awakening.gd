extends GutTest

func test_carga_limitada() -> void:
	var c := Combatant.new("Ben", 20)
	c.gain_awakening(250)
	assert_eq(c.awakening, 100)

func test_nao_desperta_sem_carga() -> void:
	var c := Combatant.new("Ben", 20)
	c.gain_awakening(80)
	assert_false(c.awaken())
	assert_eq(c.awakening, 80)
	assert_eq(c.light, 0)

func test_nao_desperta_com_pouca_luz() -> void:
	var c := Combatant.new("Ben", 20)
	c.gain_awakening(100)
	c.add_light(-1)
	assert_false(c.awaken())
	assert_eq(c.awakening, 100)
	assert_eq(c.light, -1)

func test_desperta() -> void:
	var c := Combatant.new("Ben", 20)
	c.gain_awakening(100)
	c.add_light(3)
	assert_true(c.awaken())
	assert_eq(c.awakening, 0)
	assert_eq(c.light, -2)
