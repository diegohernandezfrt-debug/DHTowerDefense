extends Control

@onready var sonido_nivelcompletado = $NivelCompletado

func _ready():
	get_parent().set_process(false)
	get_parent().set_physics_process(false)
	sonido_nivelcompletado.play()

func _on_siguiente_pressed():
	get_tree().paused = false
	GameManager.nivel_completado()
	queue_free()

func _on_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://MainMenu/main_menu.tscn")
