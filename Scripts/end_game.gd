extends Control


@export var score:Label
@export var end_track:AudioStream

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score.text = str(GlobalChar.playerscore)
	AudioBrain.music.stream = end_track
	AudioBrain.music.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	
	Fader.FadeUp("")
	await Fader.fade_finished
	get_tree().change_scene_to_file("res://Scenes/start_menu.tscn")
	Fader.FadeDown("")
