extends Node2D

var lifeTimer:float = 0.0;
var playedNeo:bool = false;

func _ready():
	$byebye.playing = true;
	$background.modulate.a = 0.0;
	get_tree().current_scene.get_node("USER_SOUL_BOX/Normal/CollisionShape2D").disabled = true;
	get_tree().current_scene.get_node("USER_SOUL_BOX").visible = false;
	get_tree().current_scene.get_node("USER_SOUL").speed = 120;
	get_tree().current_scene.get_node("enemy_jevil").visible = false;
	get_tree().current_scene.get_node("enemy_jevil").floatType = 2;

func _process(delta):
	lifeTimer += delta;
	$background.modulate.a = clamp($background.modulate.a + (delta * 2.0), 0.0, 1.0);
	
	if (!playedNeo && lifeTimer >= 8.0):
		$neochaos.playing = true;
		playedNeo = true;
	
	if (lifeTimer >= 9.0):
		$neoKnife.global_position.y += 20 * delta;
		if (!$rumble.playing): $rumble.playing = true;
		get_tree().current_scene.explodingOverlay = true;
	
	if (lifeTimer >= 15.0):
		get_tree().current_scene.explodingOverlay = false;
		get_tree().current_scene.get_node("USER_SOUL_BOX/Normal/CollisionShape2D").disabled = false;
		get_tree().current_scene.get_node("USER_SOUL_BOX").visible = true;
		get_tree().current_scene.get_node("USER_SOUL").speed = 60;
		get_tree().current_scene.get_node("enemy_jevil").visible = true;
		get_tree().current_scene.ExitAttack();
		queue_free();
