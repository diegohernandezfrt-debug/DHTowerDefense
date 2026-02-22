class_name PanelGuerrero
extends Panel

@export var textura : Texture2D
@export var tiempo_de_recuperacion : float = 2.0
@export var precio_gloria : int = 50
@export var guerrero_a_colocar : PackedScene
@export var nivel_requerido : int = 1

func _ready():
	# Configurar los parametros iniciales
	$TextureRect.texture = textura
	$Label.text = str(precio_gloria)
	# Configurar temporizador
	$Timer.wait_time = tiempo_de_recuperacion
	$Timer.one_shot = true

	actualizar_estado()

func actualizar_estado():
	if GameManager.nivel_actual < nivel_requerido:
		modulate = Color(0.4,0.4,0.4,1)
		mouse_filter = Control.MOUSE_FILTER_IGNORE
	else:
		modulate = Color(1,1,1,1)
		mouse_filter = Control.MOUSE_FILTER_STOP

func _on_gui_input(event):
	if Input.is_action_just_pressed("click_izquierdo"):
		GameManager.guerrero_seleccionado(self)
