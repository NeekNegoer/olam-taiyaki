class_name Sparks
extends RefCounted

const LIGHT_MIN := -10
const LIGHT_MAX := 10

static func chance(light: int) -> float:
	return clampf(0.5 +0.05 * light, 0.05, 0.95)

static func roll(count: int, light: int, rng: RandomNumberGenerator) -> Array[bool]:
	var results: Array[bool] = []
	for i in count:
		results.append(rng.randf() < chance(light))
	return results
