class_name GuerreroBase
extends Node2D

signal guerrero_muerto(posicion)

# Eestadisticas del Guerrero
var vida : float = 100.0
@export var vida_maxima : float = 100.0

@export var celda_ocupada : Vector2i
@export var fila : int

# Animaiones
@export var animacion : AnimationPlayer
@export var animacion_impacto : AnimationPlayer

func iniguerrero():
	vida = vida_maxima

	if animacion != null:
		if animacion.has_animation("reposo"):
			animacion.play("reposo")

func recibir_ataque(cantidad : float):
	vida -= cantidad
	# Si la guerrero se queda sin vida 
	if vida <= 0:
		guerrero_muerto.emit(celda_ocupada)
		queue_free()
		return
	if animacion_impacto != null:
		animacion_impacto.play("impacto")
