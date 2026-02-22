class_name Lanza
extends Bala

@export var daño_extra : int = 15
@export var velocidad_extra : float = 80.0

func _ready():
	daño = daño_extra
	speed = velocidad_extra
