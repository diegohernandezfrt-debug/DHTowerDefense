class_name Mundo
extends Node2D
# ==========
# Señales
# ==========
signal progreso_oleada_actualizado(actual, total)
signal oleada_cambiada(oleada)

# Sistema de oleadas
@export var oleada_actual : int = 0
@export var cantidad_de_oleadas : int = 4
@export var enemigos_por_oleada : Array[int] = [2]
@export var tiempo_de_oleadas : Array[float] = [3.0]

@export var tiempo_preparacion := 5.0
@export var max_enemigos_en_pantalla := 3
@export var delay_spawn_min := 1.2
@export var delay_spawn_max := 2.5

@export var enemigo_disponibles : Array[PackedScene]

# nodos vacíos por fila
@export var posiciones_filas : Array[Node2D] = []

var enemigos_restantes_oleada := 0

# Sistema de Enemigos
var enemigos_totales : int = 0
var enemigos_totales_oleada : int = 0
var enemigos_actuales : int = 0
 
@export var nodo_lineas : Node2D

var timer_oleada : Timer

func inicializar_mundo():
	# crear temporizador
	timer_oleada = Timer.new()
	timer_oleada.one_shot = true
	timer_oleada.autostart = false
	timer_oleada.wait_time = tiempo_de_oleadas[0]
	
	add_child(timer_oleada)
	
	# Calcular enemigos totales 
	for enemigos in enemigos_por_oleada:
		enemigos_totales += enemigos
	if oleada_actual >= enemigos_por_oleada.size():
		var enemigos = 3 + oleada_actual *2
		spawner_enemigos(enemigos)
		return
	spawner_enemigos(enemigos_por_oleada[oleada_actual])

func inicializar_oleada():
	# Checar si hay nuevas oleadas
	if oleada_actual >= enemigos_por_oleada.size():
		return
	# Verificar que existe la posicion en los array
	if oleada_actual >= enemigos_por_oleada.size():
		return
	# Spawner Enemigos
	spawner_enemigos(enemigos_por_oleada[oleada_actual])
	# Hacer que espere a la siguiente oleada 
	timer_oleada.wait_time = tiempo_de_oleadas[oleada_actual]
	timer_oleada.start()
	# ==========
	# Barra de progreso
	# ==========
	enemigos_totales_oleada = enemigos_por_oleada[oleada_actual]
	enemigos_actuales = 0
	oleada_cambiada.emit(oleada_actual)
	progreso_oleada_actualizado.emit(0, enemigos_totales_oleada)
	
func spawner_enemigos(total : int):
	enemigos_actuales = 0
	enemigos_totales_oleada = total

	for i in range(total):
		while enemigos_actuales >= max_enemigos_en_pantalla:
			await get_tree().create_timer(0.2).timeout
		spawn_enemigo()
		await  get_tree().create_timer(randf_range(delay_spawn_min, delay_spawn_max)).timeout
func enemigo_abatido():
	enemigos_actuales -= 1

	if enemigos_actuales <= 0:
		oleada_actual += 1

		if oleada_actual < enemigos_por_oleada.size():
			await get_tree().create_timer(tiempo_preparacion).timeout
			inicializar_oleada()
		else:

			while EnemyManager.total_enemigos() > 0:
				await get_tree().create_timer(0.3).timeout

			mostrar_victoria()
	# ==========
	# Barra de progreso
	# ==========
	progreso_oleada_actualizado.emit(enemigos_totales_oleada - enemigos_actuales, 
	enemigos_totales_oleada)

func mostrar_victoria():
	var victoria = load("res://Framework/UI/victoria.tscn").instantiate()
	get_tree().current_scene.add_child(victoria)

func spawn_enemigo():
	var escena_enemigo : PackedScene = enemigo_disponibles.pick_random()
	var enemigo : Enemigo = escena_enemigo.instantiate()
	var fila := obtener_fila_disponible()
	add_child(enemigo)

	if posiciones_filas.is_empty():
		return
	
	# Si esa fila ya está saturada, busca otra
	if EnemyManager.hay_enemigos_en_fila(fila):
		fila = randi() % posiciones_filas.size()

	enemigo.global_position = posiciones_filas[fila].global_position
	enemigo.fila = fila

	EnemyManager.registrar_enemigo(enemigo, fila)
	enemigos_actuales += 1

func obtener_fila_disponible() -> int:
	var filas_disponibles := []

	for i in posiciones_filas.size():
		if not EnemyManager.hay_enemigos_en_fila(i):
			filas_disponibles.append(i)

	if filas_disponibles.is_empty():
		return randi() % posiciones_filas.size()

	return filas_disponibles.pick_random()
