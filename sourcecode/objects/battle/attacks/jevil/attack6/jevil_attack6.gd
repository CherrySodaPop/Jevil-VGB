extends Node2D

var lifeTimer:float = 0.0;
var attackTimer:float = 0.0;
var attackSide:bool = false;

var bomb = preload("res://objects/battle/projectiles/jevil/projBomb.tscn")

func _ready():
	pass

func _process(delta):
	lifeTimer += delta;
	attackTimer += delta;
	
	if (attackTimer >= 0.7):
		var tmpScene = bomb.instance();
		add_child(tmpScene);
		tmpScene.explosionType = 1;
		
		if (!attackSide):
			tmpScene.global_transform.origin.x = -66;
		else:
			tmpScene.global_transform.origin.x = 66;
		tmpScene.global_transform.origin.y = -66;
		
		attackSide = !attackSide;
		attackTimer = 0.0;
	
	if (lifeTimer >= 14.0):
		get_tree().current_scene.ExitAttack();
		queue_free();
