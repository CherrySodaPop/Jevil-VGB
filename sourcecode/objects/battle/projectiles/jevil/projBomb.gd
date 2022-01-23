extends Node2D

var lifeTimer:float = 0.0;
var explodeTime:float = rand_range(0.75,1.5);
var patternHearts = preload("res://objects/battle/projectiles/jevil/patternHearts0.tscn")
var sndExplode = preload("res://objects/sounds/sndExplode.tscn");

func _ready():
	pass # Replace with function body.

func _process(delta):
	lifeTimer += delta;
	global_transform.origin.y += 80 * delta;
	if (lifeTimer >= explodeTime):
		var tmpScene = patternHearts.instance();
		tmpScene.moveDir = (get_tree().current_scene.get_node("USER_SOUL").global_transform.origin - global_transform.origin).normalized() * 60.0;
		get_parent().add_child(tmpScene);
		tmpScene.global_transform.origin = global_transform.origin;
		tmpScene = sndExplode.instance();
		get_tree().current_scene.add_child(tmpScene);
		queue_free();
