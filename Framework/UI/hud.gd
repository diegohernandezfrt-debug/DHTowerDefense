class_name HUD
extends Control

@onready var cantidad_gloria = $Gloria/HBoxContainer/MarginContainer/Label
@onready var barra_oleada := $BarraOleada
@onready var label_oleada := $OleadaLabel

var total_enemigos := 1
var enemigos_restantes := 1
var barra_ancho_max := 0.0

func _ready():
	global.gloria_actualizada.connect(actualizar_gloria)
	GameManager.hud = self
	activar_boton_cancelar(false)
	
	await get_tree().process_frame
	conectar_mundo()

func conectar_mundo():
	if GameManager.mundo_actual == null:
		return
	# ==========
	# Barra de progreso
	# ==========
	GameManager.mundo_actual.progreso_oleada_actualizado.connect(actualizar_barra)
	GameManager.mundo_actual.oleada_cambiada.connect(actualizar_oleada)

func actualizar_barra(actual: int, total: int):
	if total <= 0:
		return
	barra_oleada.max_value = total
	barra_oleada.value = actual
	if enemigos_restantes <= 0:
		barra_oleada.value = 0

func actualizar_oleada(oleada: int):
	if label_oleada:
		label_oleada.text = "Oleada " + str(oleada + 1)

func actualizar_gloria(gloria: int):
	cantidad_gloria.text = str(gloria)

func _on_b_cancel_button_down():
	GameManager.cancelar_guerrero()

func activar_boton_cancelar(valor : bool):
	$B_Cancel.visible = valor
