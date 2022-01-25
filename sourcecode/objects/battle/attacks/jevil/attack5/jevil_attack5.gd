extends Node2D

var lifeTimer:float = 0.0;
var carouselSpeed:float = 2.0;
var carouselSpeedY:float = 4.0;

func _ready():
	pass

func _process(delta):
	lifeTimer += delta;
	
	$row0.position.x = sin((lifeTimer * carouselSpeed) + deg2rad(0)) * 40.0;
	$row0.position.y = sin((lifeTimer * carouselSpeedY) + deg2rad(0)) * 10.0;
	$row0.scale.x = cos((lifeTimer * carouselSpeed) + deg2rad(0));
	$row0.z_index = sign(cos((lifeTimer * carouselSpeed) + deg2rad(0)));
	
	$row1.position.x = sin((lifeTimer * carouselSpeed) + deg2rad(90) ) * 40.0;
	$row1.position.y = sin((lifeTimer * carouselSpeedY) + deg2rad(90)) * 10.0;
	$row1.scale.x = cos((lifeTimer * carouselSpeed) + deg2rad(90));
	$row1.z_index = sign(cos((lifeTimer * carouselSpeed) + deg2rad(90)));
	
	$row2.position.x = sin((lifeTimer * carouselSpeed) + deg2rad(180)) * 40.0;
	$row2.position.y = sin((lifeTimer * carouselSpeedY) + deg2rad(180)) * 10.0;
	$row2.scale.x = cos((lifeTimer * carouselSpeed) + deg2rad(180));
	$row2.z_index = sign(cos((lifeTimer * carouselSpeed) + deg2rad(180)));
	
	$row3.position.x = sin((lifeTimer * carouselSpeed) + deg2rad(270)) * 40.0;
	$row3.position.y = sin((lifeTimer * carouselSpeedY) + deg2rad(270)) * 10.0;
	$row3.scale.x = cos((lifeTimer * carouselSpeed) + deg2rad(270));
	$row3.z_index = sign(cos((lifeTimer * carouselSpeed) + deg2rad(270)));
	
	if (lifeTimer >= 8.0):
		get_tree().current_scene.ExitAttack();
		queue_free();
