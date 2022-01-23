extends Node2D

var floatType:int = 0;
var laughing:bool = false;
var lifeTimer:float = 0.0;

var damageAmp:float = 0.0;
var damageSoundPlayed:bool = false;

var health:int = 3500;
var sleepHealth:int = 100;

func _ready():
	pass # Replace with function body.

func _process(delta):
	lifeTimer += delta;
	HandleAnimations(delta);

func HandleAnimations(delta):
	# normal up and down float
	if (floatType == 0):
		if (!laughing):
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
	
	damageAmp = clamp(damageAmp - delta * 25.0, 0.0, INF);
	if (damageAmp):
		if (!damageSoundPlayed):
			var pickSound = randi() % 2
			if (pickSound == 0):
				$ha0.playing = true;
			else:
				$ha1.playing = true;
			$hurt.playing = true;
			damageSoundPlayed = true;
		$spriteJoint.transform.origin = Vector2.ZERO;
		$spriteJoint/head.offset = Vector2(sin(lifeTimer * 10) * damageAmp, -abs(sin(lifeTimer * 10) * damageAmp));
		$spriteJoint/chainJoint/chain0.offset = $spriteJoint/head.offset * 0.80;
		$spriteJoint/chainJoint/chain1.offset = $spriteJoint/head.offset * 0.60;
		$spriteJoint/chainJoint/chain2.offset = $spriteJoint/head.offset * 0.30;
		$spriteJoint/chainJoint/chain3.offset = $spriteJoint/head.offset * 0.10;
		$spriteJoint/chainJoint.visible = true;
		$spriteJoint/head.visible = true;
		$spriteJoint/sprite.animation = "headempty"
	else:
		damageSoundPlayed = false;
		$spriteJoint/chainJoint.visible = false;
		$spriteJoint/head.visible = false;
		#$spriteJoint/sprite.animation = "idle"
		
		if (laughing):
			$spriteJoint/sprite.animation = "laugh";

func ToggleLaugh():
	laughing = !laughing;
