extends Control

@onready var sonido_campañacpmpletada = $"CampañaCompletada"

func _ready():
	get_parent().set_process(false)
	get_parent().set_physics_process(false)
	sonido_campañacpmpletada.play()

func _on_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://MainMenu/main_menu.tscn")
