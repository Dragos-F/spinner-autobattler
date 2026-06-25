extends Node2D
class_name Spinner


@export var SpinTime:float = 5
@export var WaitTime:float = 2
@onready var ResetTime:float = 5
@export var TimeCoefficient = 1.0
var ExtraWaitTime=0
var SubtractedWaitTime=0
@export var test_clicker:Clicker
var wheel:Wheel
signal sliceselected(slice:Slice,source:String)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	wheel = get_child(0)
	if wheel.item == null:
		return
	ResetTime = wheel.item.cooldown # currently set by the equipped item

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
var canBeStarted = true
func random_spin():
	if wheel.item == null:
		print("can't spin, no item assigned")
		return
	if !canBeStarted:
		return
	isSpinning = true
	var testRand = randf()
	print("RANDOM SPIN!!!!")
	print("randomspin: "+str(testRand))
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "rotation", rotation+6*PI+testRand*2*PI, SpinTime*TimeCoefficient).set_trans(Tween.TRANS_QUART).set_delay(0.3*TimeCoefficient)
	test_clicker.spining_text()
	await tween.finished
	print ("Tried to select a Slice")
	if canBeStarted:
		var pickedslice = test_clicker.select_slice()
		sliceselected.emit(pickedslice,name)
	reset_spin()

func reset_spin():
	if canBeStarted == false:
		return
	test_clicker.reset_text()
	var colourtweentime = 0.1*TimeCoefficient
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", Color.from_hsv(0,0,0.3), colourtweentime).set_delay(WaitTime*TimeCoefficient-colourtweentime*2)
	tween.tween_property(self, "rotation", 0, (ResetTime-SubtractedWaitTime+ExtraWaitTime)*TimeCoefficient).set_trans(Tween.TRANS_SINE)
	tween.tween_callback(random_spin)
	if ExtraWaitTime > 0:
		ExtraWaitTime = 0
	if SubtractedWaitTime > 0:
		SubtractedWaitTime = 0
	if canBeStarted:
		tween.tween_property(self, "modulate", Color.WHITE, colourtweentime)
		
var isSpinning = false
func _input(event):
	if event is InputEventKey and event.pressed and !event.is_echo():
		if event.keycode == KEY_SPACE:
			if !isSpinning:
				random_spin()
			
func AddExtraWait(extratime):
	ExtraWaitTime+=extratime
func SubtractWaitTime(time):
	SubtractedWaitTime+=time
