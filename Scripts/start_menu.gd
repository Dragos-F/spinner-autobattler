extends Node

@export var crt_bars:Node2D
@export var track:AudioStream
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioBrain.music.stream = track
	AudioBrain.music.play()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_pressed() -> void:
	crt_bars.visible = true
	await get_tree().create_timer(0.5).timeout
	Fader.FadeUp("")
	await Fader.fade_finished
	get_tree().change_scene_to_file("res://Scenes/CharacterSelect.tscn")
	Fader.FadeDown("")
