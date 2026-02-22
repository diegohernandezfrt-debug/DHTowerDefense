class_name GuerreroAtaque
extends GuerreroBase

@export var daño_por_disparo: float = 10
@export var tiempo_de_disparo: float = 1.0
@export var bala_instancia: PackedScene

@onready var timer: Timer = $Timer
@onready var marker_2d: Marker2D = $Marker2D

var atacando := false
@onready var animation_player = $AnimationPlayer
var zombi_al_alcance := true

@onready var tensar_arco: AudioStreamPlayer2D = $TensarArco
@onready var flecha: AudioStreamPlayer2D = $Flecha

func _ready():
	iniguerrero()
	timer.wait_time = tiempo_de_disparo
	timer.timeout.connect(intentar_disparar)
	timer.start()

func intentar_disparar():
	var fila := int(celda_ocupada.y)
	
	# if EnemyManager.hay_enemigos_en_fila(fila):
	if not EnemyManager.hay_enemigos_en_fila(fila):
		return
	animation_player.play("ataque", -1, 0.5, false)
	tensar_arco.play()

func spawnear_bala():
	var bala: Bala = bala_instancia.instantiate()
	get_tree().current_scene.add_child(bala)
	bala.global_position = marker_2d.global_position
	flecha.play()

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "ataque":
		animation_player.play("reposo")
