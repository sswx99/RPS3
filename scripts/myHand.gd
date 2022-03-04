extends Area2D

export (int) var index;
export (int) var paddingBottom;

var colorIndex = round(rand_range(1,3)); #for hands color
var isMouseInside = false;

const scoreParticle = preload("res://objects/scoreParticle.tscn");

signal score;
signal endGame;

func _enter_tree():
	# warning-ignore:return_value_discarded
	connect("score",get_parent(),"_on_score");
	# warning-ignore:return_value_discarded
	connect("endGame",get_parent(),"_on_end_game");
	
	position.y = get_viewport_rect().size.y - paddingBottom;
	getHand(index);

# warning-ignore:unused_argument
func _process(delta):
	if isMouseInside && Input.is_action_just_pressed("ui_touch"):
		index  = (index + 1) % 3;
		getHand(index);

func _on_mouse_entered():
	isMouseInside = true;

func _on_mouse_exited():
	isMouseInside = false;

func _on_body_entered(body):
	if isBeating(self,body) == "win":
		#add particle 
		var instance = scoreParticle.instance();
		instance.position = body.position; #change color of particle maybe?
		instance.emitting = true;
		get_parent().add_child(instance);
		
		#sound
		get_node("sounds/winSound").play();
		
		emit_signal("score");
		
		body.queue_free();

	elif isBeating(self,body) == "draw":
		get_node("sounds/drawSound").play();
		body.queue_free();
	else : 
		#for node in get_tree().get_nodes_in_group('enemy'):
		#	node.set_process(false);
		get_parent().get_node("background/fade/fadeOutAnimation").play("fadeInAnimation");	
		get_node("sounds/loseSound").play();
		body.queue_free();
		
		yield(get_node("sounds/loseSound"),"finished");
		emit_signal("endGame");

func getHand(index):
	$spr.texture = Arrays.spr[index][colorIndex];
	name = Arrays.names[index];

func isBeating(beats,beaten):
	if beats.index == (int(beaten.index) + 1) % 3: #beats the next one;
		return "win";
	elif beats.index == beaten.index:
		return "draw";
	else : return "lose";
