extends Area2D

var lifeTime:float = 0.0;
var pullForce:float = 120;
export (Vector2) var moveDir:Vector2 = Vector2(0,60);

func _ready():
	set_meta("projectileType", "ENEMY");
	set_meta("damageAmount", 30);
	set_meta("blockPellet", false);
	#pullForce = 60; #rand_range(30,50);

func _process(delta):
	
	lifeTime += delta;
	moveDir.y -= pullForce * delta;
	print(rotation);
	global_transform.origin += Vector2(moveDir.x * cos(rotation) + moveDir.y * cos(rotation), moveDir.x * sin(rotation) + moveDir.y * sin(rotation)) * delta;
	#position += transform * moveDir * delta;
	
	if (lifeTime > 10.0): queue_free();
