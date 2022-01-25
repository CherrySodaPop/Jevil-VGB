extends Node2D

var lifeTimer:float = 0.0;
var diamondTickMax:float = 0.2;
var diamondTickTimer:float = 0.0;

var projDiamond = preload("res://objects/battle/projectiles/jevil/projDiamond.tscn");

func _ready():
	pass

func _process(delta):
	lifeTimer += delta;
	diamondTickTimer += delta;
	
	if (diamondTickTimer >= diamondTickMax):
		var tmpScene = projDiamond.instance();
		add_child(tmpScene);
		tmpScene.transform.origin.x = rand_range(-30.0,30.0);
		tmpScene.transform.origin.y = 50.0;
		diamondTickTimer = 0.0;
	
	if (lifeTimer >= 10.0):
		get_tree().current_scene.ExitAttack();
		queue_free();
