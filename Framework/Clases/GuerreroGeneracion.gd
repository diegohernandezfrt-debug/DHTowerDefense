class_name GuerreroGeneracion
extends GuerreroBase

# Estadisticas
@export var cantidad_de_gloria : float = 25
@export var tiempo_de_generacion : float = 10.0

# Referencias
@onready var timer = $Timer
@export var escena_gloria : PackedScene

@onready var moneda_gloria: AudioStreamPlayer2D = $MonedaGloria

func _ready():
	iniguerrero()
	
	# Configurar timer
	timer.wait_time = tiempo_de_generacion
	timer.timeout.connect(generar_gloria)
	
	# Iniciar temporizador
	timer.start()
	
func generar_gloria():
	#print("GENERAR GLORIA")
	# Checar si la escena de gloria es valida
	if escena_gloria != null:
		# Creamos una instancia de nuestra escena
		var nueva_gloria : Gloria = escena_gloria.instantiate()
		@warning_ignore("narrowing_conversion")
		nueva_gloria.cantidad_gloria = cantidad_de_gloria
		# Agregamos la instancia al juego
		get_tree().current_scene.add_child(nueva_gloria)
		# Asignamos la ubicacion
		var posicion_aleatoria = randf_range(-15, 15)
		nueva_gloria.global_position = self.global_position
		nueva_gloria.global_position.x += posicion_aleatoria
		moneda_gloria.play()
