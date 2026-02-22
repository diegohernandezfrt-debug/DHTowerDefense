class_name GuerreroHacha
extends GuerreroAtaque

@export var daño_mejorado := 20
@export var tiempo_de_ataque_mejorado := 0.3

func _ready():
	super._ready()
	daño_por_disparo = daño_mejorado
	timer.wait_time = tiempo_de_ataque_mejorado

