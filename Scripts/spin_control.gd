extends Node2D
class_name Spinner


@export var SpinTime:float = 5
@export var WaitTime:float = 2
@onready var ResetTime:float = 5
@export var test_clicker:Clicker

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	var wheel:Wheel = get_child(0)
	ResetTime = wheel.item.cooldown

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func random_spin():
	var testRand = randf()
	print("RANDOM SPIN!!!!")
	print("randomspin: "+str(testRand))
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "rotation", rotation+6*PI+testRand*2*PI, SpinTime).set_trans(Tween.TRANS_QUART).set_delay(0.3)
	test_clicker.spining_text()
	await tween.finished
	print ("Tried to select a Slice")
	test_clicker.select_slice()
	reset_spin()

func reset_spin():
	test_clicker.reset_text()
	var tween = get_tree().create_tween()
	tween.tween_property(self, "rotation", 0, ResetTime).set_trans(Tween.TRANS_SINE).set_delay(WaitTime)
	tween.tween_callback(random_spin)

func _input(event):
	if event is InputEventKey and event.pressed and !event.is_echo():
		if event.keycode == KEY_SPACE:
			random_spin()
