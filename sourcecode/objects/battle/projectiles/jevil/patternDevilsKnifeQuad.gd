extends Node2D

var lifeTimer:float = 0.0;
var spinTime:float = 0.0;
var spinAmp:float = 80.0;

func _ready():
	pass

func _process(delta):
	lifeTimer += delta;
	spinTime += delta * 1.5;
	
	$projDevilsKnife0.transform.origin = Vector2(sin(spinTime), cos(spinTime)) * abs(sin(spinTime)) * spinAmp;
	$projDevilsKnife1.transform.origin = Vector2(sin(spinTime + deg2rad(180)), cos(spinTime + deg2rad(180))) * abs(sin(spinTime)) * spinAmp;
