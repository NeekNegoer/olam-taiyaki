class_name CameraFx
extends Camera2D

var _shake_tween: Tween
var _punch_tween: Tween


func shake(strength: float = 12.0, duration: float = 0.25) -> void:
	if _shake_tween and _shake_tween.is_valid():
		_shake_tween.kill()
	
	offset = Vector2.ZERO
	_shake_tween = create_tween()
	
	# Usamos um tween_method para interpolar a força do tremor de 'strength' até 0
	_shake_tween.tween_method(
		func(current_strength: float):
			offset = Vector2(
				randf_range(-current_strength, current_strength),
				randf_range(-current_strength, current_strength)
			),
		strength,
		0.0,
		duration
	)
	
	# Garante que o offset volta exatamente para zero ao terminar
	_shake_tween.tween_callback(func(): offset = Vector2.ZERO)


func punch(amount: float = 1.08, duration: float = 0.12) -> void:
	if _punch_tween and _punch_tween.is_valid():
		_punch_tween.kill()
		
	zoom = Vector2.ONE
	_punch_tween = create_tween()
	
	var half_duration := duration * 0.5
	var target_zoom := Vector2(amount, amount)
	
	# Leva o zoom até a quantidade desejada na primeira metade
	_punch_tween.tween_property(self, "zoom", target_zoom, half_duration)
	# Retorna o zoom para Vector2.ONE na segunda metade
	_punch_tween.tween_property(self, "zoom", Vector2.ONE, half_duration)
