class_name ClashTimeline
extends RefCounted

static func build(result: ClashResult) -> Array[Dictionary]:
	var steps: Array[Dictionary] = []
	
	for i in range(result.rounds.size()):
		var round_data = result.rounds[i]
		steps.append({"type": "round", "index": i})
		
		# Faíscas de A (side: 0)
		var lit_a: Array = round_data.lit_a
		for k in range(lit_a.size()):
			steps.append({
				"type": "spark",
				"side": 0,
				"slot": k,
				"lit": lit_a[k]
			})
			
		# Faíscas de B (side: 1)
		var lit_b: Array = round_data.lit_b
		for k in range(lit_b.size()):
			steps.append({
				"type": "spark",
				"side": 1,
				"slot": k,
				"lit": lit_b[k]
			})
			
		# Decidir perdedor da rodada
		var power_a: int = round_data.power_a
		var power_b: int = round_data.power_b
		var loser: int = -1
		
		if power_a < power_b:
			loser = 0
		elif power_b < power_a:
			loser = 1
			
		steps.append({
			"type": "resolve",
			"power_a": power_a,
			"power_b": power_b,
			"loser": loser
		})
		
	# Vencedor do clash
	steps.append({
		"type": "winner",
		"side": result.winner
	})
	
	# Golpes do vencedor
	for j in range(result.hits.size()):
		steps.append({
			"type": "hit",
			"side": result.winner,
			"damage": result.hits[j],
			"index": j
		})
		
	return steps
