extends Node2D

var floatType:int = 0;
var lifeTimer:float = 0.0;

var health:int = 3500;
var sleepHealth:int = 100;

func _ready():
	pass # Replace with function body.

func _process(delta):
	lifeTimer += delta;
	HandleFloating(delta);

func HandleFloating(delta):
	# normal up and down float
	if (floatType == 0):
		$spriteJoint/sprite.animation = "idle";
		$spriteJoint/sprite.frame = 0;
		$spriteJoint.transform.origin.y = sin(lifeTimer * 6) * 2.0;
		$shadow.scale.x = 1 + sin(lifeTimer * 7) * 0.15;
		$shadow.scale.y = 1 + cos(lifeTimer * 6) * 0.5;
	# oh my, moving a bit
	elif (floatType == 1):
		pass
	# CHAOS CHAOS!
	elif (floatType == 2):
		pass
