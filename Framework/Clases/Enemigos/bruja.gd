class_name Bruja
extends Enemigo

@export var tiempo_disparo : float = 2.0
@export var bala_escena : PackedScene

@onready var timer_disparo : Timer = $Timer_disparo
@onready var spawn_bala : Marker2D = $SpawnBala

func _ready():
	super._ready()
	disparar()
	timer_disparo.wait_time = tiempo_disparo
	timer_disparo.timeout.connect(disparar)
	timer_disparo.start()
	
	salud_maxima = 190.0
	salud_actual = 190.0
	tiempo_de_ataque = 1.7
	velocidad = 8.5

func disparar():
	if not is_instance_valid(self):
		return
	
	var bala = bala_escena.instantiate()
	get_tree().current_scene.add_child(bala)
	bala.global_position = spawn_bala.global_position

