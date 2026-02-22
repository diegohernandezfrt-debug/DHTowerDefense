class_name game_manager
extends Node2D

var mundo_actual : Mundo
var nivel_actual : int = 1
var cursor_guerrero : CursorGuerrero
var hud : HUD

# SISTEMA DE COLOCAR GUERREROS
var celda_valida : bool = false
var mostrar_cursor_guerrero : bool = false

var guerreros_colocados : Dictionary = {}
var panel_guerrero_actual : PanelGuerrero
var posicion_actual : Vector2i
var celda_actual : CeldaGuerrero

func _physics_process(delta):
	if cursor_guerrero != null and mostrar_cursor_guerrero:
		cursor_guerrero.global_position = get_global_mouse_position()

func cargar_nivel(numero):
	nivel_actual = numero
	# Reinicio de mapa
	guerreros_colocados.clear()
	panel_guerrero_actual = null
	celda_actual = null
	posicion_actual = Vector2i.ZERO
	
	EnemyManager.limpiar() # Limpiar enemigos fantasmas

	get_tree().change_scene_to_file("res://Framework/Mundo_0" + str(numero) + ".tscn")
	await get_tree().process_frame

func reiniciar_juego():
	nivel_actual = 1
	guerreros_colocados.clear()
	panel_guerrero_actual = null
	posicion_actual = Vector2i.ZERO
	celda_actual = null
	mostrar_cursor_guerrero = false

	global.gloria = 0
	global.gloria_actualizada.emit(global.gloria)

func guerrero_seleccionado(panel_guerrero : PanelGuerrero):
	# Por algun motivo no pude agregar mi clase global  como "Global" y quedo en "global"
	if global.gloria < panel_guerrero.precio_gloria:
		return
		# Actualizar la variable
	panel_guerrero_actual = panel_guerrero
	# Mostrar el cursor 
	if mostrar_cursor_guerrero == false:
		mostrar_cursor_guerrero = true
		cursor_guerrero.actualizar_visuales(panel_guerrero)
		mundo_actual.mostrar_celdas(true)
		hud.activar_boton_cancelar(true)
	
func actualizar_celda_actual(pos : Vector2i, celda : CeldaGuerrero):
	cursor_guerrero.establecer_celda_valida(!guerreros_colocados.has(pos))
	posicion_actual = pos
	celda_actual = celda
	
func intentar_colocar_guerrero():
	if panel_guerrero_actual and not guerreros_colocados.has(posicion_actual):
		# Crear una instancia del guerrero a colocar
		var nuevo_guerrero = panel_guerrero_actual.guerrero_a_colocar.instantiate()
		# Agregar mi guerrero al nodo del mundo
		mundo_actual.guerreros.add_child(nuevo_guerrero)
		# Colocarle la posicion global
		nuevo_guerrero.global_position = celda_actual.global_position
		# Agregar el guerrero a mi diccionario
		guerreros_colocados[posicion_actual] = nuevo_guerrero
		# Quitarle la gloria
		global.quitar_gloria(panel_guerrero_actual.precio_gloria)
		# Reestablecer las variables
		panel_guerrero_actual = null
		celda_actual = null
		mostrar_cursor_guerrero = false
		mundo_actual.mostrar_celdas(false)
		cursor_guerrero.actualizar_visuales(null)
		hud.activar_boton_cancelar(false)
		
		nuevo_guerrero.celda_ocupada = posicion_actual
		nuevo_guerrero.fila = posicion_actual.y
		nuevo_guerrero.guerrero_muerto.connect(_on_guerrero_muerto)

func _on_guerrero_muerto(posicion):
	if guerreros_colocados.has(posicion):
		guerreros_colocados.erase(posicion)

func cancelar_guerrero():
	# Reestablecer las variables
	panel_guerrero_actual = null
	celda_actual = null
	mostrar_cursor_guerrero = false
	mundo_actual.mostrar_celdas(false)
	cursor_guerrero.actualizar_visuales(null)
	hud.activar_boton_cancelar(false)

func nivel_completado():
	nivel_actual += 1
	if nivel_actual <= 5:
		cargar_nivel(nivel_actual)
	else:
		get_tree().change_scene_to_file("res://Framework/UI/victoria_final.tscn")

func game_over():
	get_tree().paused = true
	await get_tree().create_timer(0.5).timeout
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Framework/UI/game_over.tscn")
