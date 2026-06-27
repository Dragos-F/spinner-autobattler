extends Node

@export var crt_bars:Node2D
@export var track:AudioStream
@export var bonusfeatureswindow:Control
@export var optionsmenuwindow:Control
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioBrain.music.stream = track
	AudioBrain.music.play()
	_on_backtomenu_pressed()

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

func _on_backtomenu_pressed() -> void:
	print("back to main screen")
	bonusfeatureswindow.visible = false
	optionsmenuwindow.visible = false

func _on_bonusbutton_pressed() -> void:
	print("show bonus features")
	bonusfeatureswindow.visible = true
	
func _on_options_pressed() -> void:
	print("show options")
	optionsmenuwindow.visible = true
