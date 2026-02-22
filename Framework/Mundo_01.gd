class_name Mundo_01
extends Mundo

@onready var celdas = $Celdas
@onready var cursor_guerrero = $CursorGuerrero
@onready var guerreros = $Guerreros
@export var gloria_inicial : int = 500

func _ready():
	global.gloria = gloria_inicial
	global.gloria_actualizada.emit(global.gloria)
	# Establecer las variables del Game Manager
	GameManager.mundo_actual = self
	GameManager.cursor_guerrero = $CursorGuerrero
	# Crear celdas
	crear_celdas()
	celdas.visible = false
	# Inicializar clase
	inicializar_mundo()
	
func mostrar_celdas(valor: bool):
	celdas.visible = valor

func crear_celdas():
	var celda_paquete := load("res://Framework/Clases/celda_guerrero.tscn")
	for x in range(0,8):
		for y in range(0,5):
			var nueva_celda = celda_paquete.instantiate()
			celdas.add_child(nueva_celda)
			nueva_celda.position = Vector2(15,17.5) + (Vector2(x,y) * Vector2(30 * 1.05, 35 * 1.1))
			nueva_celda.posicion_celda = Vector2i(x,y)

func _on_area_game_over_area_entered(area):
	if area.get_parent() is Enemigo:
		GameManager.game_over()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		abrir_pausa()

func abrir_pausa():
	if get_tree().paused:
		return

	var pausa = preload("res://Framework/UI/Pausa.tscn").instantiate()
	add_child(pausa)
