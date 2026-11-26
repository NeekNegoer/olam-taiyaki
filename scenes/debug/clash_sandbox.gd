class_name ClashSandbox
extends Control

@onready var light_a: SpinBox = %LightA
@onready var light_b: SpinBox = %LightB
@onready var chance_label: Label = %ChanceLabel
@onready var clash_button: Button = %ClashButton
@onready var log_label: RichTextLabel = %Log

var skill_a := SkillData.make(&"golpe", 4, 3, 2, SkillData.Stone.RED)
var skill_b := SkillData.make(&"garra", 3, 4, 2, SkillData.Stone.YELLOW)


func _ready() -> void:
	light_a.value_changed.connect(atualizar_chance)
	light_b.value_changed.connect(atualizar_chance)
	clash_button.pressed.connect(confrontar)
	atualizar_chance()


func atualizar_chance(_valor: float = 0) -> void:
	var chance := ClashOdds.win_chance(skill_a, int(light_a.value), skill_b, int(light_b.value))
	chance_label.text = "Chance de vencer: %d%%" % roundi(chance * 100)


func confrontar() -> void:
	var rng := RandomNumberGenerator.new()
	rng.randomize()
	
	var resultado := Clash.resolve(
		skill_a, 
		int(light_a.value), 
		skill_b, 
		int(light_b.value), 
		rng
	)
	
	log_label.clear()
	
	for rodada in resultado.rounds:
		var texto_a := faiscas_texto(rodada.lit_a)
		var texto_b := faiscas_texto(rodada.lit_b)
		var linha := "A %s (%d) x (%d) B %s\n" % [texto_a, rodada.power_a, rodada.power_b, texto_b]
		log_label.append_text(linha)
		
	var nome_vencedor = "A" if resultado.winner == 0 else "B"
	log_label.append_text("\nVencedor: %s\n" % nome_vencedor)
	log_label.append_text("Golpes: %s" % str(resultado.hits))


func faiscas_texto(lit: Array) -> String:
	var texto := ""
	for acendeu in lit:
		if acendeu:
			texto += "🔥"
		else:
			texto += "·"
	return texto
