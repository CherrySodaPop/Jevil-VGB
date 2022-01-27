extends Node2D

var lifeTimer:float = 0.0;
var explodeTime:float = rand_range(0.6,1.5);
var sndExplode = preload("res://objects/sounds/sndExplode.tscn");

export (int) var explosionType = 0;

var patternHearts = preload("res://objects/battle/projectiles/jevil/patternHearts0.tscn")
var patternSpades = preload("res://objects/battle/projectiles/jevil/patternSpades2.tscn")

func _ready():
	pass

func _process(delta):
	lifeTimer += delta;
	global_transform.origin.y += 80 * delta;
	match explosionType:
		0: $sprite.animation = "bombHeart";
		1: $sprite.animation = "bombSpade";
	if (lifeTimer >= explodeTime):
		var tmpScene = null;
		match explosionType:
			0:
				tmpScene = patternHearts.instance();
				tmpScene.moveDir = (get_tree().current_scene.get_node("USER_SOUL").global_transform.origin - global_transform.origin).normalized() * 60.0;
			1: tmpScene = patternSpades.instance();
		get_parent().add_child(tmpScene);
		tmpScene.global_transform.origin = global_transform.origin;
		tmpScene = sndExplode.instance();
		get_tree().current_scene.add_child(tmpScene);
		queue_free();
