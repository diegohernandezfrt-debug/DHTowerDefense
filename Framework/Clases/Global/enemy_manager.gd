class_name enemy_manager
extends Node

var enemigos_por_fila : Dictionary = {}

# =========================
# REGISTRO DE ENEMIGOS
# =========================
func registrar_enemigo(enemigo: Enemigo, fila: int) -> void:
	if not enemigos_por_fila.has(fila):
		enemigos_por_fila[fila] = []
	enemigos_por_fila[fila].append(enemigo)

# =========================
# ELIMINACIÓN DE ENEMIGOS
# =========================
func eliminar_enemigo(enemigo: Enemigo, fila: int) -> void:
	if not enemigos_por_fila.has(fila):
		return
	
	enemigos_por_fila[fila].erase(enemigo)

# =========================
# CONSULTAS
# =========================
func hay_enemigos_en_fila(fila: int) -> bool:
	if not enemigos_por_fila.has(fila):
		return false
		
	enemigos_por_fila[fila] = enemigos_por_fila[fila].filter(
		func(e): return is_instance_valid(e)
	)
		
	return not enemigos_por_fila[fila].is_empty()

func obtener_enemigos_en_fila(fila: int) -> Array:
	if not enemigos_por_fila.has(fila):
		return []

	return enemigos_por_fila[fila]

func total_enemigos() -> int:
	var total := 0
	for fila in enemigos_por_fila.keys():
		total += enemigos_por_fila[fila].size()
	return total

func limpiar():
	enemigos_por_fila.clear()

func reiniciar():
	enemigos_por_fila.clear()
