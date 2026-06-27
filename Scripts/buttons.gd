extends HBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	Fader.FadeUp("")
	await Fader.fade_finished
	get_tree().change_scene_to_file("res://Scenes/start_menu.tscn") 
	Fader.FadeDown("")
	



func _on_mute_toggled(toggled_on: bool) -> void:
	if toggled_on:
		AudioBrain.mute()
	else:
		AudioBrain.unmute()
