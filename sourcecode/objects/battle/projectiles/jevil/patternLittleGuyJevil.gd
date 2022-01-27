extends AnimatedSprite

export (float) var explodeTime:float = 0.75;
var lifeTimer:float = 0.0;
var attackSide:bool = false; # false = facing right, true = facing left
var exploded:bool = false;
var spades = preload("res://objects/battle/projectiles/jevil/patternSpades1.tscn")
var sndOh = preload("res://objects/sounds/sndJevilOh.tscn");

func _ready():
	scale.x = 0;

func _process(delta):
	lifeTimer += delta;
	
	if (lifeTimer < explodeTime):
		if (!attackSide):
			scale.x = clamp(scale.x - (delta * 3.0), -1.0, 0.0);
		else:
			scale.x = clamp(scale.x + (delta * 3.0), 0.0, 1.0);
	
	if (lifeTimer >= explodeTime && !exploded):
		var tmpScene = spades.instance();
		get_parent().add_child(tmpScene);
		tmpScene.global_transform.origin = global_transform.origin;
		tmpScene.look_at(get_tree().current_scene.get_node("USER_SOUL").global_transform.origin);
		tmpScene = sndOh.instance();
		get_tree().current_scene.add_child(tmpScene);
		animation = "shock";
		exploded = true;
	
	if (lifeTimer >= explodeTime + 0.5):
		if (!attackSide):
			scale.x = clamp(scale.x + (delta * 3.0), -1.0, 0.0);
		else:
			scale.x = clamp(scale.x - (delta * 3.0), 0.0, 1.0);
		if (scale.x == 0.0):
			queue_free();
