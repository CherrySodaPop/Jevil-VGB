extends Area2D

var lifeTime:float = 0.0;
export (int) var visisbleType:int = 0;

func _ready():
	$duck.visible = false;
	if (visisbleType == 0):
		$duck.visible = true;
	if (visisbleType == 1):
		$everyman.visible = true;
	if (visisbleType == 2):
		$horse.visible = true;
	set_meta("projectileType", "ENEMY");
	set_meta("damageAmount", 30);

func _process(delta):
	lifeTime += delta;
	$CollisionShape2D.disabled = sign(get_parent().scale.x) != 1
