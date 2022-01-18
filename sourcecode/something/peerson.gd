extends Node2D

var canSpeek:bool = false;
var speakDelay:float = 0.0;
export (String, MULTILINE) var words:String = "My name?";
export (float) var speed:float = 1.0;

func _ready():
	$text.visible_characters = 1;
	$text.percent_visible = 0.0;
	$text.bbcode_text = words;

func _process(delta):
	if(canSpeek):
		speakDelay += delta * speed;
		if (speakDelay > 0.25 && $text.percent_visible < 1.0):
			$text.visible_characters += 1;
			speakDelay = 0.0;
		if (speakDelay >= 8.0 && $text.percent_visible >= 1.0):
			modulate.a = 0.0;
