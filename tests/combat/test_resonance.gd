extends GutTest

const R := SkillData.Stone.RED
const Y := SkillData.Stone.YELLOW
const W := SkillData.Stone.WHITE

func test_sequencia_vermelha() -> void:
	assert_eq(Resonance.bonuses([R, R, R, R]), [0, 1, 2, 2])

func test_cor_diferente_quebra() -> void:
	assert_eq(Resonance.bonuses([R, Y, R]), [0, 0, 0])

func test_duas_sequencias() -> void:
	assert_eq(Resonance.bonuses([W, W, Y, Y]), [0, 1, 0, 1])

func test_vazio() -> void:
	assert_eq(Resonance.bonuses([]), [])
