extends Node2D

var lifeTimer:float = 0.0;
var floatType:int = 0;
var laughing:bool = false;
var metamorphosis:bool = false;
var metamorphosisTimer:float = 0.0;
var metamorphosisPlayed:bool = false;

var damageAmp:float = 0.0;
var damageSoundPlayed:bool = false;

var health:int = 2000;
var sleepHealth:int = 100;

var dizzyTimer:float = 10.0;

var defeated:bool = false;
var defeatedTimer:float = 0.0;

var triggeredTired:bool = false;
var tired:bool = false;

func _ready():
	pass # Replace with function body.

func _process(delta):
	lifeTimer += delta;
	
	if (!triggeredTired && (health <= 600 || sleepHealth <= 16)):
		tired = true;
		triggeredTired = true;
	
	if (health <= 0 || sleepHealth <= 0):
		get_tree().current_scene.revolveTheWorld = false;
		floatType = 0;
		defeated = true;
	if (defeated):
		defeatedTimer += delta;
		if (defeatedTimer >= 2.0):
			if (!get_tree().current_scene.get_node("prejoker").playing): get_tree().current_scene.get_node("prejoker").playing = true;
			metamorphosis = true;
		if (defeatedTimer >= 5.0):
			get_tree().current_scene.battleEnd = true;
	
	if (metamorphosis):
		if (!metamorphosisPlayed):
			$metamorphosis.playing = true;
			metamorphosisPlayed = true;
		metamorphosisTimer += delta * 6.0;
		if (metamorphosisTimer <= (PI/2)):
			$spriteJoint.scale.x = cos(metamorphosisTimer);
		else:
			$spriteJoint.scale.x = 0.0;
		if (metamorphosisTimer > (5 * PI)/2):
			$devilsKnife.position.y -= (180 * delta);
			$devilsKnife.scale.x = 1.0;
			$devilsKnife.modulate.a = clamp($devilsKnife.modulate.a - (delta * 2.0), 0.0, 1.0);
		$devilsKnife.scale.x = sin(metamorphosisTimer);
	
	HandleAnimations(delta);

func HandleAnimations(delta):
	# normal up and down float
	if (floatType == 0):
		if (!laughing):
			$spriteJoint/sprite.animation = "idle";
			$spriteJoint/sprite.speed_scale = 1.0;
			$spriteJoint/sprite.frame = 0;
			$spriteJoint.transform.origin.y = sin(lifeTimer * 6) * 2.0;
			$shadow.scale.x = 1 + sin(lifeTimer * 7) * 0.15;
			$shadow.scale.y = 1 + cos(lifeTimer * 6) * 0.5;
		$spriteJoint/sprite.speed_scale = 1.0;
		$spriteJoint/sprite.modulate.a = 1.0;
		$shadow.visible = !defeated;
		$spriteJoint/multipleJevils.visible = false;
	# oh my, moving a bit
	elif (floatType == 1):
		$spriteJoint/sprite.animation = "bounce";
		$spriteJoint/sprite.speed_scale = 1.0;
		$spriteJoint.transform.origin.y = sin(lifeTimer * 6) * 2.0;
		$shadow.scale.x = 1 + sin(lifeTimer * 7) * 0.15;
		$shadow.scale.y = 1 + cos(lifeTimer * 6) * 0.5;
		$spriteJoint/sprite.speed_scale = 1.0;
		$spriteJoint/sprite.modulate.a = 1.0;
		$shadow.visible = true;
		$spriteJoint/multipleJevils.visible = false;
	# CHAOS CHAOS!
	elif (floatType == 2):
		$spriteJoint/multipleJevils/jevil0/sprite.position.x = -sin(lifeTimer * 6.0) * 18.0;
		$spriteJoint/multipleJevils/jevil0/sprite.position.y = -cos(lifeTimer * 6.0) * 18.0;
		$spriteJoint/multipleJevils/jevil0/sprite.modulate.a = clamp(sin(lifeTimer * 8.0), 0.0, 1.0);
		
		$spriteJoint/multipleJevils/jevil1/sprite.position.x = sin(lifeTimer * 6.0) * 18.0;
		$spriteJoint/multipleJevils/jevil1/sprite.position.y = cos(lifeTimer * 6.0) * 18.0;
		$spriteJoint/multipleJevils/jevil1/sprite.modulate.a = clamp(cos(lifeTimer * 8.0 + ((3*PI) / 2)), 0.0, 1.0);
		
		$spriteJoint/multipleJevils/jevil2/sprite.position.x = -sin(lifeTimer * 6.0) * 18.0;
		$spriteJoint/multipleJevils/jevil2/sprite.position.y = -cos(lifeTimer * 6.0) * 18.0;
		$spriteJoint/multipleJevils/jevil2/sprite.modulate.a = clamp(sin(lifeTimer * 8.0 + 3), 0.0, 1.0);
		
		$spriteJoint/multipleJevils/jevil3/sprite.position.x = -sin(lifeTimer * 10.0) * 20.0;
		$spriteJoint/multipleJevils/jevil3/sprite.position.y = -cos(lifeTimer * 10.0) * 20.0;
		$spriteJoint/multipleJevils/jevil3/sprite.modulate.a = clamp(cos(lifeTimer * 8.0 + 6), 0.0, 1.0);
		
		$spriteJoint/sprite.animation = "bounce";
		$spriteJoint/sprite.speed_scale = 1.5;
		$spriteJoint/sprite.modulate.a = clamp(sin(lifeTimer * 8.0 + PI), 0.0, 1.0);
		$spriteJoint.transform.origin.y = sin(lifeTimer * 6) * 2.0;
		$shadow.visible = false;
		$spriteJoint/multipleJevils.visible = true;
		
	damageAmp = clamp(damageAmp - delta * 25.0, 0.0, INF);
	if (damageAmp):
		if (!defeated):
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
			$spriteJoint/multipleJevils.visible = false;
			$spriteJoint/sprite.modulate.a = 1.0;
		else:
			if (!damageSoundPlayed):
				var pickSound = randi() % 2
				if (pickSound == 0):
					$ha0.playing = true;
				else:
					$ha1.playing = true;
				$hurt.playing = true;
				damageSoundPlayed = true;
			$spriteJoint/sprite.animation = "shock";
			$spriteJoint/multipleJevils.visible = false;
			$spriteJoint/sprite.modulate.a = 1.0;
	else:
		damageSoundPlayed = false;
		$spriteJoint/chainJoint.visible = false;
		$spriteJoint/head.visible = false;
		
		if (laughing):
			$spriteJoint/sprite.animation = "laugh";
		
		if (tired):
			$spriteJoint/sprite.animation = "tired";
	
	if (dizzyTimer == 0.0): $dizzySound.playing = true;
	dizzyTimer += delta;
	$dizzy.modulate.a = clamp(1.0 - dizzyTimer, 0.0, 1.0);
	$dizzy/ring0.position = Vector2(-sin(dizzyTimer * 3.0) * 10.0, -cos(dizzyTimer * 3.0) * 10.0);
	$dizzy/ring1.position = Vector2(-sin(dizzyTimer * 6.0) * 20.0, -cos(dizzyTimer * 6.0) * 20.0);
	$dizzy/ring2.position = Vector2(-sin(dizzyTimer * 8.0) * 30.0, -cos(dizzyTimer * 8.0) * 30.0);

func ToggleLaugh():
	laughing = !laughing;
