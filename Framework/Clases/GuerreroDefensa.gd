class_name GuerreroDefensa
extends GuerreroBase

@export var vida_extra : float = 100.0


func _ready():
	iniguerrero()
	vida_maxima += vida_extra
	vida += vida_extra
