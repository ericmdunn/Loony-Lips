#Hello World done before starting on Loony Lips


extends Node

# Declare member variables here. Examples:
var greeting = "Hello"
var target = "world!"
var i = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	print(greeting + " " + target)
	print("5" + str(2))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	i = i + 1
	if(i > 100):
		print(1/delta)
		i = 0
	
