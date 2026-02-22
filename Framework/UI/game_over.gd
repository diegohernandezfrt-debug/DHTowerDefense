extends Control

@onready var sonido_gameover = $GameOverSound

func _ready():
	sonido_gameover.play()

func _on_reintentar_pressed():
	GameManager.cargar_nivel(GameManager.nivel_actual)

func _on_menu_pressed():
	get_tree().change_scene_to_file("res://MainMenu/main_menu.tscn")
