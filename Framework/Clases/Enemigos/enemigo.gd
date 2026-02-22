class_name Enemigo
extends CharacterBody2D

# Estados
enum {CAMINAR, COMER, ABATIDO}

var estado_actual := CAMINAR
var estado_previo

# Estadisticas de salud
@export var salud_maxima : float = 100.0
var salud_actual : float = 100.0

# Estadisticas de ataque 
@export var fila : int = 0
@export var ataque : float = 20.0
@export var tiempo_de_ataque : float = 1.5
var guerrero_a_atacar : GuerreroBase

# Movimiento 
@export var velocidad : float = 8.0
var direccion := -1

@onready var animacion = $AnimationPlayer
@onready var atacar_guerrero_timer = $AtacarGuerreroTimer
@onready var animacion_impacto = $AnimacionImpacto
@onready var sonido_muerte_vampiro: AudioStreamPlayer2D = $SonidoMuerte
@onready var flecha_impacto: AudioStreamPlayer2D = $FlechaImpacto

func _ready():
	# Establecer salud maxima
	salud_actual = salud_maxima
	atacar_guerrero_timer.wait_time = tiempo_de_ataque
	atacar_guerrero_timer.timeout.connect(atacar_guerrero)

func _physics_process(delta):
	# Checar si el estado ha cambiado
	if estado_actual != estado_previo:
		match estado_actual:
			CAMINAR:
				animacion.play("caminar")
			COMER:
				animacion.play("comer")
			ABATIDO:
				animacion.play("abatido")
		estado_previo = estado_actual
	# Poner la velocidad 
	if estado_actual == CAMINAR:
		velocity.x = velocidad * direccion
	else:
		velocity.x = 0
		
	move_and_slide()

func _on_detector_area_entered(area):
	estado_actual = COMER
	guerrero_a_atacar = area.get_parent()
	atacar_guerrero()

func _on_detector_area_exited(area):
	estado_actual = CAMINAR
	guerrero_a_atacar = null
	atacar_guerrero_timer.stop()

func atacar_guerrero():
	# Verificar si la planta es valida
	if guerrero_a_atacar != null:
		guerrero_a_atacar.recibir_ataque(ataque)
		atacar_guerrero_timer.start()

func recibir_ataque(cantidad: float):
	salud_actual -= cantidad
	
	# Checar si tiene salud
	if salud_actual <= 0:
		morir()
		return
	animacion_impacto.play("impacto")
	flecha_impacto.play()

var muerto := false
func morir():
	if muerto:
		return

	muerto = true
	EnemyManager.eliminar_enemigo(self, fila)
	
	estado_actual = ABATIDO
	atacar_guerrero_timer.stop()
	velocity = Vector2.ZERO

	animacion.play("abatido")
	sonido_muerte_vampiro.play()
	await animacion.animation_finished
	
	GameManager.mundo_actual.enemigo_abatido()
	queue_free()
	
func activar_game_over():
	if muerto:
		return
	GameManager.game_over()
