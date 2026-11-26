class_name ClashOdds
extends RefCounted

const SAMPLES := 2000


static func win_chance(a: SkillData, light_a: int, b: SkillData, light_b: int, bonus_a: int = 0, bonus_b: int = 0, p_seed: int = 12345) -> float:
	var rng := RandomNumberGenerator.new()
	rng.seed = p_seed
	var wins: int = 0
	for i in SAMPLES:
		var result := Clash.resolve(a, light_a, b, light_b, rng, bonus_a, bonus_b)
		if result.winner == 0:
			wins += 1
			
	return float(wins) / SAMPLES
