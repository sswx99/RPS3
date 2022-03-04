extends Node

# warning-ignore:unused_class_variable
var spr = [
[
preload("res://assets/hand_sprites/rock/Rock.png"),
preload("res://assets/hand_sprites/rock/Rock1.png"),
preload("res://assets/hand_sprites/rock/Rock2.png"),
preload("res://assets/hand_sprites/rock/Rock3.png"),
],

[
preload("res://assets/hand_sprites/paper/Paper.png"),
preload("res://assets/hand_sprites/paper/Paper1.png"),
preload("res://assets/hand_sprites/paper/Paper2.png"),
preload("res://assets/hand_sprites/paper/Paper3.png"),
],

[
preload("res://assets/hand_sprites/scissors/Scissors.png"),
preload("res://assets/hand_sprites/scissors/Scissors1.png"),
preload("res://assets/hand_sprites/scissors/Scissors2.png"),
preload("res://assets/hand_sprites/scissors/Scissors3.png"),
],
];

# warning-ignore:unused_class_variable
var names = ["rock","paper","scissors"];

# warning-ignore:unused_class_variable
var xPos = [96,288,480];


func _init():
	randomize();
	print("Game initialized");