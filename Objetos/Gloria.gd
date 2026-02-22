class_name Gloria
extends Area2D

var cantidad_gloria := 25

func _ready():
	$AnimatedSprite2D.play("default")
	$AnimationPlayer.play("start")

func _on_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click_derecho"):
		# Agregar gloria al jugador
		
		global.agregar_gloria(cantidad_gloria)
		# Destruir el objeto
		queue_free()
