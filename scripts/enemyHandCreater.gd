extends Node2D

const enemyHand = preload("res://objects/enemyHand.tscn");
var enemyHandCounter = 0;
var timer;

var formerPosX = Arrays.xPos[floor(rand_range(0,1)*3)];
var formerHandIndex = floor(rand_range(0,1)*3);


export (int) var posY;
export (float) var speed;
export (float) var interval;
export (float) var speedIncrement;

func _enter_tree():
	createEnemyHand();

func _on_timeout():
	var formerTimer = timer;
	formerTimer.queue_free();
	createEnemyHand();

func createEnemyHand():
	var instance = getEnemyHand();
	
	#adjust instance
	instance.speed = speed;
	instance.add_to_group('enemy');
	instance.position = Vector2(getPosX(),posY);
	enemyHandCounter += 1;
	add_child(instance);
	
	printDebug();
	
	timer = createTimer();
	
	#
	speedIncrement = speedIncrement - (speedIncrement) / 200 if speedIncrement >= 0.1 else 0.1 ;
	var formerSpeed = speed;
	speed += speedIncrement;
	if (int(formerSpeed) % 50) > (int(speed) % 50):
		interval = interval - (interval / 100); 

func createTimer():
	var timer = Timer.new();
	
	timer.wait_time = float(interval / speed);
	timer.one_shot = true;
	timer.connect("timeout",self,"_on_timeout");
	
	add_child(timer);
	timer.start();
	
	return timer;

func getPosX():
	#get different pos from former enemy hand
	var posX = Arrays.xPos[floor(rand_range(0,1)*3)];
	while posX == formerPosX:
		posX = Arrays.xPos[floor(rand_range(0,1)*3)];
	formerPosX = posX;
	return posX;

func getEnemyHand():
	#get different hand from former enemy hand
	var instance = enemyHand.instance();
	while instance.index == formerHandIndex:
		instance.index = floor(rand_range(0,1)*3);
	formerHandIndex = instance.index;
	return instance;

func printDebug(): # debug
	print(
	"Speed : " + str(speed), 
	", Time : " + str(interval/speed), 
	", Count : " + str(enemyHandCounter),
	", Increment : " + str(speedIncrement),
	", Interval : " + str(interval));
