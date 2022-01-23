extends KinematicBody2D

var disableSoul:bool = false;
var disableMovement:bool = true;

var health:int = 150;
var healthMax:int = 150;
var damaged:bool = false;
var damageMultiplier:float = 1.0;
var invisTimer:float = 0.0;
var flashTimer:float = 0.0;
var guard:bool = false;

var movementActionStrength:float = 0.2;
var speed = 60;

func _ready():
	$HitboxCollisionSoul.connect("area_entered",self,"_TouchingArea");

func _process(delta):
	
	health = clamp(health, -INF, healthMax);
	
	if (damaged):
		if (invisTimer == 0.0): $soulHurt.playing = true;
		invisTimer += delta;
		flashTimer += delta;
	
	if (flashTimer >= 0.1):
		$spriteJoint.visible = !$spriteJoint.visible;
		flashTimer = 0.0;
	
	if (invisTimer >= 1.0):
		damaged = false;
		invisTimer = 0.0;
		$spriteJoint.visible = true;
		flashTimer = 0.0;
	
	if (!disableSoul):
		HandleMovement(delta);

func HandleMovement(delta):
	var vecVelocity:Vector2 = Vector2.ZERO;
	
	if (!disableMovement):
		if (Input.get_action_strength("moveUp") > movementActionStrength):
			vecVelocity += Vector2(0,-speed);
		
		if (Input.get_action_strength("moveDown") > movementActionStrength):
			vecVelocity += Vector2(0,speed);
		
		if (Input.get_action_strength("moveLeft") > movementActionStrength):
			vecVelocity += Vector2(-speed,0);
			
		if (Input.get_action_strength("moveRight") > movementActionStrength):
			vecVelocity += Vector2(speed,0);
			
	move_and_slide(vecVelocity);
	
func EnableBattle():
	disableSoul = false;
	disableMovement = false;
	visible = true;

func DisableBattle():
	disableSoul = true;
	disableMovement = true;
	visible = false;
	guard = false;

func _TouchingArea(area:Area2D):
	if (disableSoul): return;
	
	if (area && area.has_meta("projectileType") && area.get_meta("projectileType") == "ENEMY"):
		if (!damaged):
			if (area.has_meta("damageAmount")):
				health -= int((area.get_meta("damageAmount") * damageMultiplier) / ( 1.0 + float(guard)) );
			Persistant.get_node("controllerCamera").shakeAmp = 2.0;
			damaged = true;
