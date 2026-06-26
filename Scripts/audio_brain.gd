extends Node2D
@export var music:AudioStreamPlayer2D
@export var clacks:AudioStreamPlayer2D
@export var fx:AudioStreamPlayer2D
@export var fx_options:Array[AudioStream]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func play_fx(tone:int):
	if tone >0:
		fx.stream = fx_options[0]
		fx.play()
	if tone <0:
		fx.stream = fx_options[1]
	if tone == 0:
		fx.stream = fx_options[2]
	fx.play()

func mute():
	music.volume_db = -99
	clacks.volume_db = -99
	fx.volume_db = -99
	
func unmute():
	music.volume_db = 0
	clacks.volume_db = -15
	fx.volume_db = 0
