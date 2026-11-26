class_name HitStop
extends RefCounted

static func freeze(tree: SceneTree, duration: float = 0.06, slow: float = 0.05) -> void:
	Engine.time_scale = slow
	await tree.create_timer(duration, true, false, true).timeout
	Engine.time_scale = 1.0
