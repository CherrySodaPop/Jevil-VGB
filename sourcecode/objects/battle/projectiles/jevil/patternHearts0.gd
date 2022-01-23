extends Node2D

var lifeTime:float = 0.0;
var spinTime:float = 0.0;
var moveDir:Vector2 = Vector2.ZERO;

func _ready():
	pass

func _process(delta):
	lifeTime += delta;
	spinTime += delta * 2.0;
	
	global_transform.origin += moveDir * delta;
	
	$projHeart0.transform.origin = Vector2(sin(spinTime) * 20, cos(spinTime) * 20);
	$projHeart1.transform.origin = Vector2(sin(spinTime - deg2rad(90)) * 20, cos(spinTime - deg2rad(90)) * 20);
	$projHeart2.transform.origin = Vector2(sin(spinTime - deg2rad(180)) * 20, cos(spinTime - deg2rad(180)) * 20);
	$projHeart3.transform.origin = Vector2(sin(spinTime - deg2rad(270)) * 20, cos(spinTime - deg2rad(270)) * 20);
	
	if (lifeTime > 30.0): queue_free();
