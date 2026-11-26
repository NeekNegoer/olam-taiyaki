class_name Clash
extends RefCounted

const MAX_ROUNDS := 100

static func resolve(a: SkillData, light_a: int, b: SkillData, light_b: int, rng: RandomNumberGenerator, bonus_a: int = 0, bonus_b: int = 0) -> ClashResult:
	var result := ClashResult.new()
	var sa: int = a.sparks
	var sb: int = b.sparks

	while sa > 0 and sb > 0 and result.rounds.size() < MAX_ROUNDS:
		var lit_a := Sparks.roll(sa, light_a, rng)
		var lit_b := Sparks.roll(sb, light_b, rng)

		var power_a: int = a.base_power + bonus_a + lit_a.count(true) * a.spark_bonus
		var power_b: int = b.base_power + bonus_b + lit_b.count(true) * b.spark_bonus

		if power_a < power_b:
			sa -= 1
		elif power_b < power_a:
			sb -= 1

		result.rounds.append({
			"power_a": power_a,
			"power_b": power_b,
			"lit_a": lit_a,
			"lit_b": lit_b,
			"sparks_a": sa,
			"sparks_b": sb
		})

	var a_wins := sb == 0 or (sa != 0 and sa >= sb)

	var winner_skill: SkillData
	var winner_sparks: int
	var winner_light: int
	var winner_bonus: int

	if a_wins:
		result.winner = 0
		winner_skill = a
		winner_sparks = sa
		winner_light = light_a
		winner_bonus = bonus_a
	else:
		result.winner = 1
		winner_skill = b
		winner_sparks = sb
		winner_light = light_b
		winner_bonus = bonus_b

	var lit := Sparks.roll(winner_sparks, winner_light, rng)
	for acendeu in lit:
		var damage: int = winner_skill.base_power + winner_bonus
		if acendeu:
			damage += winner_skill.spark_bonus
		result.hits.append(damage)

	return result
