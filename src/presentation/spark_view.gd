class_name SparkView
extends Node2D

const LIT_COLOR := Color("#FFC34D")
const SNUFF_COLOR := Color("#2B2233")

@onready var gem: Polygon2D = $Gem
@onready var burst: GPUParticles2D = $Burst
var _tween: Tween

func ignite() -> void:
	burst.visible = true
	if _tween:
		_tween.kill()
	gem.color = LIT_COLOR
	modulate.a = 1.0
	burst.restart()
	_tween = create_tween()
	_tween.tween_property(self, "scale", Vector2(1.4, 1.4), 0.08)
	_tween.tween_property(self, "scale", Vector2.ONE, 0.12)

func snuff() -> void:
	burst.visible = false
	if _tween:
		_tween.kill()
	_tween = create_tween().set_parallel()
	_tween.tween_property(gem, "color", SNUFF_COLOR, 0.2)
	_tween.tween_property(self, "scale", Vector2(0.7, 0.7), 0.2)
	_tween.tween_property(self, "modulate:a", 0.4, 0.2)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		match event.keycode:
			KEY_1:
				ignite()
			KEY_2:
				snuff()
