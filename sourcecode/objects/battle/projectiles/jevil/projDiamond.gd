extends Area2D

var lifeTime:float = 0.0;
export (float) var pullForce:float = 120;
export (Vector2) var moveDir:Vector2 = Vector2(0,60);
export (float) var waitTime:float = 0.0;

func _ready():
	set_meta("projectileType", "ENEMY");
	set_meta("damageAmount", 30);

func _process(delta):
	lifeTime += delta;
	if (waitTime <= lifeTime):
		moveDir.y -= pullForce * delta;
		var correctedRotation = rotation + deg2rad(90) + get_parent().rotation;
		global_transform.origin += Vector2(moveDir.x * cos(correctedRotation) + moveDir.y * cos(correctedRotation), moveDir.x * sin(correctedRotation) + moveDir.y * sin(correctedRotation)) * delta;
		#position += transform * moveDir * delta;
	
	if (lifeTime > 30.0): queue_free();
