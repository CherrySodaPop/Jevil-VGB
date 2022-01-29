extends Node2D

var lifeTimer:float = 0.0;

var battleDamage:int = 125;
var battleWireDamage:int = 6;
var battleDamageRandomRange:int = 100;

var battleReady:bool = false;
var battleEnemyAttacking:bool = false;
var battleEnemyAttackCount:int = 0;
var battleShowHud:bool = false;
var battleSelectionHud:int = 0;
var battleInputWaitTimeHud:float = 0.0;
var battleSelectionConfirmed:bool = false;
var battleSelectionWaitTime:float = 0.0;
var battleIncreaseDifficulty:bool = false;
var battleSpecialAttack:bool = false;
var battleEnd:bool = false;

var SOUL_BOX_ROTATION:float = 0.0;

var explodingOverlay:bool = false;
var revolveTheWorld:bool = false;
var carouselAlpha:float = 0.0;

var attack0 = preload("res://objects/battle/attacks/jevil/attack0/jevil_attack0.tscn");
var attack1 = preload("res://objects/battle/attacks/jevil/attack1/jevil_attack1.tscn");
var attack2 = preload("res://objects/battle/attacks/jevil/attack2/jevil_attack2.tscn");
var attack3 = preload("res://objects/battle/attacks/jevil/attack3/jevil_attack3.tscn");
var attack4 = preload("res://objects/battle/attacks/jevil/attack4/jevil_attack4.tscn");
var attack5 = preload("res://objects/battle/attacks/jevil/attack5/jevil_attack5.tscn");
var attack6 = preload("res://objects/battle/attacks/jevil/attack6/jevil_attack6.tscn");
var attack7 = preload("res://objects/battle/attacks/jevil/attack7/jevil_attack7.tscn");

func _ready():
	$AnimationPlayer.play("intro");

func _process(delta):
	lifeTimer += delta;
	if (revolveTheWorld):
		$world/jevilBackground3D/Viewport/jevilBackground/jevilFloor.rotate_y(1.25 * delta);
		$world/jevilBackground3D/Viewport/jevilBackground/jevilCarousel.rotate_object_local(Vector3.UP,-0.75 * delta);
		carouselAlpha = clamp(carouselAlpha + (delta * 0.05), 0.0, 0.05);
	else:
		carouselAlpha = clamp(carouselAlpha - (delta * 0.05), 0.0, 0.05);
	$world/jevilBackground3D/Viewport/jevilBackground/jevilCarousel/jevilCarousel.mesh.surface_get_material(0).set_emission_energy(carouselAlpha);
	
	if (explodingOverlay):
		$ExplosionOverlay.modulate.a = clamp($ExplosionOverlay.modulate.a + (delta * 0.2), 0.0, 1.0);
	else:
		$ExplosionOverlay.modulate.a = clamp($ExplosionOverlay.modulate.a - (delta * 2.0), 0.0, 1.0);
	
	if (battleEnd):
		modulate.a = clamp(modulate.a - (delta * 0.15), 0.0, 1.0);
		$prejoker.volume_db -= 5 * delta;
		if (modulate.a == 0.0):
			get_tree().change_scene("res://rooms/creditsAndMenu/creditsAndMenu.tscn");
	
	HandleBattle(delta);
	HandleBattleHud(delta);
	HandleBattleVisuals(delta);

func HandleBattle(delta):
	if (!battleReady): return;
	
	if ($USER_SOUL.health <= 0):
		Persistant.get_node("controller").USER_SOUL_POS = $USER_SOUL.transform.origin;
		get_tree().change_scene("res://rooms/anEnd/ANEND.tscn");
	
	if ($enemy_jevil.health <= 0):
		battleReady = false;
		battleShowHud = false;
		$joker.playing = false;
	
	if ($enemy_jevil.sleepHealth <= 0):
		battleReady = false;
		battleShowHud = false;
		$joker.playing = false;
	
	#HandleBattleHud(delta);
	
	if (battleSelectionConfirmed):
		battleSelectionWaitTime += delta;
		
		if (battleSelectionWaitTime >= 1.0):
			$USER_SOUL.global_transform.origin = Vector2(0,0);
			if (!battleEnemyAttacking): HandleAttack();
			battleShowHud = false;
			battleEnemyAttacking = true;
		
		if (battleSelectionWaitTime >= 1.2):
			$USER_SOUL.EnableBattle();
			battleSelectionConfirmed = false;
			battleSelectionWaitTime = 0.0;
			battleEnemyAttackCount += 1;

func HandleAttack():
	if (!battleSpecialAttack && ($enemy_jevil.health <= 500 || $enemy_jevil.sleepHealth <= 15)):
		$enemy_jevil.tired = false;
		battleEnemyAttackCount = 7;
		battleIncreaseDifficulty = true;
		battleSpecialAttack = true;
	
	if (battleEnemyAttackCount == 0):
		var tmpScene = attack1.instance();
		get_tree().current_scene.add_child(tmpScene);
		return;
	if (battleEnemyAttackCount == 1):
		var tmpScene = attack0.instance();
		get_tree().current_scene.add_child(tmpScene);
		return;
	if (battleEnemyAttackCount == 2):
		var tmpScene = attack2.instance();
		get_tree().current_scene.add_child(tmpScene);
		return;
	if (battleEnemyAttackCount == 3):
		var tmpScene = attack3.instance();
		get_tree().current_scene.add_child(tmpScene);
		return;
	if (battleEnemyAttackCount == 4):
		var tmpScene = attack4.instance();
		get_tree().current_scene.add_child(tmpScene);
		return;
	if (battleEnemyAttackCount == 5):
		var tmpScene = attack5.instance();
		get_tree().current_scene.add_child(tmpScene);
		if ($enemy_jevil.floatType == 0): $enemy_jevil.floatType = 1;
		return;
	if (battleEnemyAttackCount == 6):
		var tmpScene = attack6.instance();
		get_tree().current_scene.add_child(tmpScene);
		battleEnemyAttackCount = -1;
		return
	if (battleSpecialAttack && battleEnemyAttackCount == 7):
		var tmpScene = attack7.instance();
		get_tree().current_scene.add_child(tmpScene);
		battleEnemyAttackCount = 4;
		return;

func HandleBattleHud(delta):
	if (!battleShowHud):
		battleInputWaitTimeHud = 0.0;
		return;
	
	battleInputWaitTimeHud += delta;
	
	if (battleInputWaitTimeHud < 0.75): return;
	
	if (battleSelectionConfirmed): return;
	
	if (battleReady):
		if (Input.is_action_just_pressed("moveLeft")):
			battleSelectionHud -= 1;
		if (Input.is_action_just_pressed("moveRight")):
			battleSelectionHud += 1;
	battleSelectionHud = clamp(battleSelectionHud,0,2);
	
	if (battleReady):
		if (Input.is_action_just_pressed("confirm")):
			if (battleSelectionHud == 0):
				$enemy_jevil.sleepHealth -= battleWireDamage;
				$enemy_jevil.dizzyTimer = 0.0;
			if (battleSelectionHud == 1):
				$enemy_jevil.health -= battleDamage + int(rand_range(-battleDamageRandomRange/2,battleDamageRandomRange/2));
				$enemy_jevil.damageAmp = 30;
			if (battleSelectionHud == 2):
				$USER_SOUL.health += 60;
				$heal.playing = true;
			
			battleSelectionConfirmed = true;

func HandleBattleVisuals(delta):
	# battle hud
	if (battleShowHud):
		$BattleHud.transform.origin.y += (75 - $BattleHud.transform.origin.y) * (15 * delta);
	else:
		$BattleHud.transform.origin.y += (100 - $BattleHud.transform.origin.y) * (15 * delta);
	
	if (battleReady):
		$HealthHud.transform.origin.y += (-$HealthHud.transform.origin.y) * (30 * delta);
	else:
		$HealthHud.transform.origin.y += (-10 - $HealthHud.transform.origin.y) * (30 * delta);
	
	$HealthHud/Line2D.points[1].x = -81 + clamp(float($USER_SOUL.health) / float($USER_SOUL.healthMax), 0.0, 1.0) * 54;
	
	$BattleHud/pacify.frame = (battleShowHud && battleSelectionHud == 0);
	$BattleHud/fight.frame = (battleShowHud && battleSelectionHud == 1);
	$BattleHud/heal.frame = (battleShowHud && battleSelectionHud == 2);
	
	# the box thingy
	if (battleEnemyAttacking):
		SOUL_BOX_ROTATION = rad2deg(lerp(deg2rad(SOUL_BOX_ROTATION),0, 10 * delta));
		$USER_SOUL_BOX.scale = $USER_SOUL_BOX.scale + (Vector2(2,2) * delta);
	else:
		SOUL_BOX_ROTATION = rad2deg(lerp(deg2rad(SOUL_BOX_ROTATION),PI, 8 * delta));
		$USER_SOUL_BOX.scale = $USER_SOUL_BOX.scale - (Vector2(2,2) * delta);
		
		if ($USER_SOUL_BOX.scale.x < 0.1):
			$USER_SOUL_BOX/Normal.visible = true;
			$USER_SOUL_BOX/Normal/CollisionShape2D.disabled = false;
			$USER_SOUL_BOX/Wide.visible = false;
			$USER_SOUL_BOX/Wide/CollisionShape2D.disabled = true;
		
		#$world/OverlayBright.modulate.a = $world/OverlayBright.modulate.a - (delta * 2.0);
	
	$USER_SOUL_BOX.rotation_degrees = round(SOUL_BOX_ROTATION);
	$USER_SOUL_BOX.scale.x = clamp($USER_SOUL_BOX.scale.x, 0.0, 1.0);
	$USER_SOUL_BOX.scale.y = clamp($USER_SOUL_BOX.scale.y, 0.0, 1.0);

func ExitAttack():
	battleShowHud = true;
	battleEnemyAttacking = false;
	$USER_SOUL.DisableBattle();

func SHARK_TO_SHARK():
	battleReady = true;
	battleShowHud = true;
	revolveTheWorld = true;
	#$worldRevolving.playing = true;
