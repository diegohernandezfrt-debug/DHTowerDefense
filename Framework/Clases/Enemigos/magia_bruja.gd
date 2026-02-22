class_name BalaEnemiga
extends Area2D

@export var speed : float = 200
@export var daño : int = 10

func _process(delta):
	position.x -= speed * delta

func _on_body_entered(body):
	if body is GuerreroBase:
		body.recibir_ataque(daño)
		queue_free()


func _on_area_entered(area):
	var posible_guerrero = area.get_parent()

	if posible_guerrero is GuerreroBase:
		posible_guerrero.recibir_ataque(daño)
		queue_free()
