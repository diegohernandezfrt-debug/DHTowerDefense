class_name CursorGuerrero
extends Node2D

@onready var sprite = $Sprite2D

func actualizar_visuales(panel_guerrero : PanelGuerrero):
	if panel_guerrero == null:
		sprite.texture = null
		return
	sprite.texture = panel_guerrero.textura
	
func establecer_celda_valida(valor : bool):
	if valor:
		sprite.self_modulate = Color(1.0, 1.0, 1.8, 0.8)
	else:
		sprite.self_modulate = Color(0.82, 0.246, 0.246, 1)
