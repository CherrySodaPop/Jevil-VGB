extends Node2D

var lifeTimer:float = 0.0;
var enableMenu:bool = false;
var currentChoice:int = 0;

var something = preload("res://something/room_something.tscn");

func _ready():
	pass

func _process(delta):
	lifeTimer += delta;
	
	if (lifeTimer <= 9.0 && lifeTimer >= 5.0):
		$Credits.modulate.a = 1.0;
	else:
		$Credits.modulate.a = clamp($Credits.modulate.a - (delta / 4.0), 0.0, 1.0);
	
	if (lifeTimer >= 15.0):
		if ($AUDIO_STORY.playing == false):
			$AUDIO_STORY.playing = true;
		
		$Menu.modulate.a = clamp($Menu.modulate.a + (delta / 2.0), 0.0, 1.0);
		
		if (Input.is_action_just_pressed("moveUp")):
			currentChoice -= 1;
		if (Input.is_action_just_pressed("moveDown")):
			currentChoice += 1;
		currentChoice = clamp(currentChoice,0,2);
		
		$Menu/Label3.visible = (currentChoice == 2);
		
		if (currentChoice == 0):
			$Menu/USER_SOUL.transform.origin.y = lerp($Menu/USER_SOUL.transform.origin.y, -10, 10 * delta);
		elif (currentChoice == 1):
			$Menu/USER_SOUL.transform.origin.y = lerp($Menu/USER_SOUL.transform.origin.y, 15, 10 * delta);
		elif (currentChoice == 2):
			$Menu/USER_SOUL.transform.origin.y = lerp($Menu/USER_SOUL.transform.origin.y, 40, 10 * delta);
		
		if (Input.is_action_just_pressed("confirm")):
			if (currentChoice == 0):
				get_tree().change_scene("res://rooms/jevilFight/jevilFight.tscn");
			if (currentChoice == 1):
				modulate.a = 0.0;
				get_tree().quit();
			if (currentChoice == 2):
				get_tree().change_scene_to(something);
