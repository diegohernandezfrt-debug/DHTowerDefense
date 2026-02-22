extends Control

func _ready():
	get_tree().paused = true

func _on_reanudar_pressed():
	get_tree().paused = false
	queue_free()

func _on_menu_pressed():
	get_tree().paused = false
	GameManager.reiniciar_juego()
	EnemyManager.reiniciar()
	get_tree().change_scene_to_file("res://MainMenu/main_menu.tscn")

