class_name MainMenu
extends Control

var tiempo:= 0.0

func _ready():
	$AnimationPlayer.play("MenuMovimiento")
	$Personajes.play("personajes")
	$Musica.play()

func _process(delta):
	tiempo += delta
	$Marco.position.y += sin(tiempo * 2) * 0.2
	$Letrero.position.y += sin(tiempo * 2) * 0.2

func _on_button_mouse_entered():
	$Boton.scale = Vector2(1.05, 1.05)

func _on_button_mouse_exited():
	$Boton.scale = Vector2(1, 1)

func _on_button_pressed():
	GameManager.reiniciar_juego()
	EnemyManager.reiniciar()
	get_tree().change_scene_to_file("res://Framework/Mundo_01.tscn")
	$AnimationPlayer.play("MenuMovimiento")
