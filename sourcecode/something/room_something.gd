extends Node2D

var lifeTimer:float = 0.0;

func _ready():
	OS.set_window_title("Somewhere.")

func _process(delta):
	lifeTimer += delta;
	
	if (lifeTimer >= 4.0):
		$text0.canSpeek = true;
	
	if (lifeTimer >= 7.0):
		$text1.canSpeek = true;
	
	if (lifeTimer >= 15.0):
		$text2.canSpeek = true;
	
	if (lifeTimer >= 20.0):
		$text3.canSpeek = true;
	
	if (lifeTimer >= 25.0):
		$lunar.visible = true
