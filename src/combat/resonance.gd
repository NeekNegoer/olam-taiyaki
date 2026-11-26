class_name Resonance
extends RefCounted

const MAX_BONUS := 2


static func bonuses(stones: Array) -> Array[int]:
	var resultado: Array[int] = []
	var sequencia: int = 0
	var cor_anterior = -1
	
	for stone in stones:
		if stone == cor_anterior:
			sequencia += 1
		else:
			sequencia = 0
			
		resultado.append(mini(sequencia, MAX_BONUS))
		cor_anterior = stone
		
	return resultado
