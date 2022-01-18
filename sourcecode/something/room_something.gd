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
	
	if (lifeTimer >= 10.0):
		$text2.canSpeek = true;
	
	if (lifeTimer >= 15.0):
		$text3.canSpeek = true;
	
	if (lifeTimer >= 19.0):
		$text4.canSpeek = true;
	
	if (lifeTimer >= 24.0):
		$text5.canSpeek = true;
	
	if (lifeTimer >= 29.0):
		$text6.canSpeek = true;
	
	if (lifeTimer >= 35.0):
		$text7.canSpeek = true;
	
	if (lifeTimer >= 41.0):
		$text8.canSpeek = true;
	
	if (lifeTimer >= 47.0):
		$text9.canSpeek = true;
