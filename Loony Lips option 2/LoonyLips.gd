extends Control


var player_words = []
var intro = "Welcome to Loony Lips. This is a word game similar to the popular book series Mad Libs.  "

var current_story = {}

onready var PlayerInput = $VBoxContainer/HBoxContainer/PlayerInput
onready var DisplayText = $VBoxContainer/DisplayText

# Called when the node enters the scene tree for the first time.
func _ready():
	set_current_story()
	greet_player()
	check_player_words_length()
	PlayerInput.grab_focus()
#	DisplayText.text = story % prompts

func set_current_story():
	var stories = get_from_json("StoryBook.json")
	randomize()
	current_story = stories[randi() % stories.size()]
#	var story_count = $StoryBook.get_child_count()
#	var selected_story = randi() % story_count
#	current_story.prompts = $StoryBook.get_child(selected_story).prompts
#	current_story.story = $StoryBook.get_child(selected_story).story

func get_from_json(filename):
	var file = File.new()
	file.open(filename, File.READ)
	var text = file.get_as_text()
	var data = parse_json(text)
	file.close()
	return data

func greet_player():
	DisplayText.text = intro



func _on_PlayerInput_text_entered(new_text):
	add_player_words()
	check_player_words_length()

func _on_TextureButton_pressed():
	if(is_story_done()):
		get_tree().reload_current_scene()
	else:
		add_player_words()
		check_player_words_length()

func add_player_words():
	if(not PlayerInput.text == ""):
		player_words.append(PlayerInput.text)
		clear_DisplayText()
	PlayerInput.clear()

func clear_DisplayText():
	DisplayText.text = ""

func is_story_done():
	return player_words.size() >= current_story.prompts.size()

func check_player_words_length():
	if(is_story_done()):
		end_game()
	else:
		prompt_player()

func tell_story():
	DisplayText.text = current_story.story % player_words

func prompt_player():
	DisplayText.text += "May I have " + current_story.prompts[player_words.size()] + " Please?"

func end_game():
	PlayerInput.queue_free()
	$VBoxContainer/HBoxContainer/Label.text = "Again!"
	tell_story()
