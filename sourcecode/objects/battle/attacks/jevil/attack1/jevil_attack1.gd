extends Node2D

var lifeTimer:float = 0.0;
var jevilTimer:float = 0.0;
var jevilMaxTimer:float = 0.75;
var attackSide:bool = false; # false = left, true = right
var littleJevil = preload("res://objects/battle/projectiles/jevil/patternLittleGuyJevil.tscn");

func _ready():
	pass

func _process(delta):
	lifeTimer += delta;
	jevilTimer += delta;
	
	if (jevilTimer >= jevilMaxTimer):
		if (!attackSide):
			var tmpScene = littleJevil.instance();
			tmpScene.attackSide = attackSide;
			add_child(tmpScene);
			tmpScene.transform.origin.x = -66;
		else:
			var tmpScene = littleJevil.instance();
			tmpScene.attackSide = attackSide;
			add_child(tmpScene);
			tmpScene.transform.origin.x = 66;
		attackSide = !attackSide;
		jevilTimer = 0.0;
	
	if (lifeTimer >= 10.0):
		get_tree().current_scene.ExitAttack();
		queue_free();
