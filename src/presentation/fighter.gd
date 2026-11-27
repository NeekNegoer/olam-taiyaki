class_name Fighter
extends Node2D

@export var facing: int = 1
const SPARK_SCENE := preload("res://scenes/combat/spark_view.tscn")

@onready var body: Polygon2D = $Body
@onready var name_label: Label = $NameLabel
@onready var spark_row: Node2D = $SparkRow

var home: Vector2


func _ready() -> void:
	home = global_position
	body.scale.x = facing


func lunge(distance: float = 120.0, duration: float = 0.25) -> void:
	var tween := create_tween()
	var target_pos := home + Vector2(distance * facing, 0)
	tween.tween_property(self, "global_position", target_pos, duration).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	await tween.finished


func recoil(distance: float = 40.0, duration: float = 0.2) -> void:
	var tween := create_tween()
	var initial_pos := global_position
	var recoil_pos := initial_pos - Vector2(distance * facing, 0)
	tween.tween_property(self, "global_position", recoil_pos, duration * 0.5).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "global_position", initial_pos, duration * 0.5).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	await tween.finished


func return_home(duration: float = 0.2) -> void:
	var tween := create_tween()
	tween.tween_property(self, "global_position", home, duration).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	await tween.finished


func flash() -> void:
	var tween := create_tween()
	modulate = Color(3, 3, 3)
	tween.tween_property(self, "modulate", Color.WHITE, 0.1)

func show_sparks(count: int) -> void:
	for filho in spark_row.get_children():
		spark_row.remove_child(filho)
		filho.queue_free()
	for i in count:
		var s := SPARK_SCENE.instantiate()
		spark_row.add_child(s)
		s.position.x = i * 28 - (count -1) * 28 / 2.0

func spark(slot: int) -> SparkView:
	return spark_row.get_child(slot)
