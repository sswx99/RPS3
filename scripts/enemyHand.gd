extends KinematicBody2D

var speed;
var index = floor(rand_range(0,1)*3);

const enemyHandTail = preload("res://objects/enemyHandTail.tscn");

func _enter_tree():
	GetHand(index);

func _process(delta):
	move_local_y(delta*speed);

func GetHand(index):
	#get texture and name of hand according to index
	$spr.texture = Arrays.spr[index][ round(rand_range(1,3)) ];
	name = Arrays.names[index];
	
	#create enemyHandTail instance
	var instance = enemyHandTail.instance();
	instance.texture = Arrays.spr[index][ round(rand_range(1,3)) ];
	add_child(instance);
