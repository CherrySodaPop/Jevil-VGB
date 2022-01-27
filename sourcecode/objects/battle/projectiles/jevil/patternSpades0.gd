extends Node2D

func _ready():
	modulate.a = 0.0;

func _process(delta):
	modulate.a = clamp(modulate.a + (delta * 3.0), 0.0, 1.0);
