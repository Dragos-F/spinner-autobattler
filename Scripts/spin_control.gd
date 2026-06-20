extends Sprite2D
class_name Spinner

@export var SpinTime:float = 1
@export var WaitTime:float = 5
@export var ResetTime:float = 5
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func random_spin():
	var testRand = randf()
	print("RANDOM SPIN!!!!")
	print("randomspin: "+str(testRand))
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "rotation", rotation+6*PI+testRand*2*PI, SpinTime).set_trans(Tween.TRANS_QUART)
	tween.chain().tween_property(self, "rotation", 0, ResetTime).set_trans(Tween.TRANS_SINE).set_delay(WaitTime)
	pass

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_SPACE:
			random_spin()
