class_name  Bala
extends Area2D

var daño := 10
var speed := 100.0
# Aqui declaramos un paquete de escenas para poder elegir el deseado a utilizar
@export var BALA_IMPACTO : PackedScene

func _physics_process(delta):
	position.x += speed * delta
	

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_area_entered(area):
	if area.get_parent() is Enemigo:
		var enemigo := area.get_parent() as Enemigo

		# Spawnear el impacto de bala
		var impacto = BALA_IMPACTO.instantiate()
		get_tree().current_scene.add_child(impacto)
		impacto.global_position = global_position

		# Aplicarle el daño al enemigo
		enemigo.recibir_ataque(daño)
		# Eliminar bala
		queue_free()
