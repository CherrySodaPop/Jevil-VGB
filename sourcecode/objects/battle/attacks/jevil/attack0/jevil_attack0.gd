extends Node2D

var lifeTimer:float = 0.0;

var spadeCreationTime = 2.0;
var spadeCreationFreq = 2.0;
var pattern0 = preload("res://objects/battle/projectiles/jevil/patternSpades0Jevil.tscn");

func _ready():
	pass

func _process(delta):
	lifeTimer += delta;
	spadeCreationTime += delta;
	if (spadeCreationTime >= spadeCreationFreq):
		var tmpScene = pattern0.instance();
		add_child(tmpScene);
		spadeCreationTime = 0.0;
	if (lifeTimer > 9.0):
		get_tree().current_scene.ExitAttack();
		queue_free();
