class_name FighterTest
extends Node2D

@onready var fighter_a: Fighter = $FighterA
@onready var fighter_b: Fighter = $FighterB


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		match event.keycode:
			KEY_1:
				fighter_a.lunge()
				fighter_b.lunge()
			KEY_2:
				fighter_a.recoil()
				fighter_b.recoil()
			KEY_3:
				fighter_a.return_home()
				fighter_b.return_home()
			KEY_4:
				fighter_a.flash()
				fighter_b.flash()
			KEY_5:
				fighter_a.show_sparks(4)
				fighter_b.show_sparks(4)
			KEY_6:
				fighter_a.spark(0).ignite()
