extends Node2D

const DEBUG = true

var saveFile = "user://saveFile.save" if !DEBUG else "";
var score : int = 0;
var highscore : int;

var red : float;
var blue : float;
var green : float;

var steps : int = 0;
var increment : float = 0.01; #color rgb increment


func _enter_tree():
	loadGame();

func _ready():
	get_node("ui/column/highscoreText").text = "Highscore : " + str(highscore);
	get_node("background").color = Color (red,green,blue);
	adjustSize();
	get_tree().paused = true;

func _on_score():
	#write score to screen
	score += 1;
	get_node("scoreText").text = str(score);
	
	#change background color
	increaseColor();
	$background.color = Color(red,green,blue,1);
	print("Score : ",score, " Color: ", $background.color, " Step: ", str(steps)); #debug

func _on_end_game():
	highscore = score if score > highscore else highscore;
	saveGame();
	
	Ads.showInterAd();
	
	# warning-ignore:return_value_discarded
	get_tree().reload_current_scene();

func _on_playButton_pressed():
	Ads.hideBannerAd();
	
	get_node("ui").queue_free();
	get_node("background/fade/fadeOutAnimation").play("fadeOutAnimation");
	get_node("scoreText").visible = true;
	get_tree().paused = false;

func increaseColor():
	if steps == 0:
		green += increment;
		if green >= 1:
			steps = 1;
	elif steps == 1:
		red -= increment;
		if red <= 0.34:
			steps = 2;
	elif steps == 2:
		blue += increment;
		if blue >= 1:
			steps = 3;
	elif steps == 3:
		green -= increment;
		if green <= 0.34:
			steps = 4;
	elif steps == 4:
		red += increment;
		if red >= 1:
			steps = 5;
	elif steps == 5:
		blue -= increment;
		if blue <= 0.34:
			steps = 0;
	else:
		# warning-ignore:return_value_discarded
		get_tree().reload_current_scene();
		print_debug("There was an error while increasing color!");

func saveGame():
	# get data to dictionary
	var saveDict = {
		background = {
			red = red,
			green = green,
			blue = blue
		},
		highscore = highscore
	};
	#save to file and close it
	var file = File.new();
	file.open(saveFile,File.WRITE);
	file.store_line(to_json(saveDict));
	file.close();

func loadGame():
	var file = File.new();
	if not file.file_exists(saveFile):
		# if file is not exists give standart values
		highscore = 0;
		red = 1;
		green = 0.34;
		blue = 0.34;
	else :
		file.open(saveFile,File.READ);
		var data = parse_json(file.get_as_text());
		file.close();
		#get values from file;
		highscore = data['highscore'];
		red = data['background']['red'];
		green = data['background']['green'];
		blue = data['background']['blue'];

func adjustSize():
	get_node("background").rect_size = get_viewport_rect().size;
	get_node("scoreText").rect_size = get_viewport_rect().size;
	get_node("ui").rect_size = get_viewport_rect().size;
	get_node("ui/playButton").rect_size = get_viewport_rect().size;
