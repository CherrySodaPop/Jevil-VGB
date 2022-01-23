extends Area2D

var lifeTime:float = 0.0;

func _ready():
	set_meta("projectileType", "ENEMY");
	set_meta("damageAmount", 30);

func _process(delta):
	lifeTime += delta;
	if (lifeTime > 30.0): queue_free();
