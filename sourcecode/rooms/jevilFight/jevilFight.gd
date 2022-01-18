extends Node2D

var lifeTimer:float = 0.0;

func _ready():
	pass

func _process(delta):
	lifeTimer += delta;
	$jevilBackground3D/Viewport/jevilBackground/jevilFloor.rotate_y(1.25 * delta);
	
