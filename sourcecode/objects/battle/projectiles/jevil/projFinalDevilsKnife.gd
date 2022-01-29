extends Area2D

var lifeTime:float = 0.0;
var explode:bool = false;
var explodeTimer:float = 0.0;

func _ready():
	set_meta("projectileType", "ENEMY");
	set_meta("damageAmount", 20);

func _process(delta):
	lifeTime += delta;
	$Sprite.rotation += -8.0 * delta;
	
	if (global_position.y <= 80):
		global_position.y += 200 * delta;
	
	$explosionSprite.scale.x = clamp($explosionSprite.scale.x - (delta * 5.0), 0.0, 1.0);
	
	if (!explode && global_position.y >= 60):
		get_parent().get_node("kaboom").playing = true;
		$explosionSprite.scale.x = 1.0;
		$explodeCollision.disabled = false;
		$mainCollision.disabled = true;
		$Sprite.visible = false;
		explode = true;
	
	if (explode):
		explodeTimer += delta;
		if (explodeTimer >= 0.1):
			$explodeCollision.disabled = true;
	
	if (lifeTime > 50.0): queue_free();
