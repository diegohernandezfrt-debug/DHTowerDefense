class_name Global
extends Node

signal gloria_actualizada(cantidad)

var gloria : int = 500
var sonido_gloria : AudioStreamPlayer

func _ready():
	await get_tree().create_timer(0.5).timeout
	gloria_actualizada.emit(gloria)
	
	sonido_gloria = AudioStreamPlayer.new()
	add_child(sonido_gloria)
	sonido_gloria.stream = preload("res://MusicSound/Monedas.mp3")
	sonido_gloria.volume_db = -5
	await get_tree().create_timer(0.5).timeout
	gloria_actualizada.emit(gloria)

func agregar_gloria(cantidad):
	gloria += cantidad
	gloria_actualizada.emit(gloria)
	if sonido_gloria:
		sonido_gloria.play()
	
func quitar_gloria(cantidad):
	gloria -= cantidad
	gloria_actualizada.emit(gloria)
