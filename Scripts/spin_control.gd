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
var spintween:Tween
var resettween:Tween
signal sliceselected(slice:Slice,source:String)
signal spinInterruptComplete()
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
	if isResetting:
		print("called while resetting, so wait.")
		return
	#if !isSpinning:
	#var colourtween = get_tree().create_tween()
	#colourtween.tween_property(self, "modulate", Color.WHITE, .5)
	isSpinning = true
	var testRand = randf()
	print("RANDOM SPIN!!!!")
	#print("randomspin: "+str(testRand))
	spintween = get_tree().create_tween()
	if modulate != Color.WHITE:
		spintween.tween_property(self, "modulate", Color.WHITE, 1*TimeCoefficient)
	spintween.set_ease(Tween.EASE_OUT)
	spintween.tween_property(self, "rotation", rotation+6*PI+testRand*2*PI, SpinTime*TimeCoefficient).set_trans(Tween.TRANS_QUART).set_delay(0.3*TimeCoefficient)
	test_clicker.spining_text()
	await spintween.finished
	print ("Tried to select a Slice")
	if canBeStarted:
		var pickedslice = test_clicker.select_slice()
		sliceselected.emit(pickedslice,name)
	print("resetting after random spin")
	reset_spin()

	
var isResetting = false
func reset_spin():
	if canBeStarted == false:
		return
	isResetting = true
	test_clicker.reset_text()
	var colourtweentime = 0.1*TimeCoefficient
	resettween = get_tree().create_tween()
	resettween.tween_property(self, "modulate", Color.from_hsv(0,0,0.3), colourtweentime).set_delay(WaitTime*TimeCoefficient-colourtweentime*2*TimeCoefficient)
	resettween.tween_property(self, "rotation", 0, (ResetTime-SubtractedWaitTime+ExtraWaitTime)*TimeCoefficient).set_trans(Tween.TRANS_SINE)
	#resettween.
	resetspinComplete.emit()
	print("end of resettween")
	if ExtraWaitTime > 0:
		ExtraWaitTime = 0
	if SubtractedWaitTime > 0:
		SubtractedWaitTime = 0
	if canBeStarted:
		print("tweening white")
		resettween.tween_property(self, "modulate", Color.WHITE, colourtweentime)
		resettween.tween_callback(random_spin)
	isResetting = false
	
var isSpinning = false
func _input(event):
	if event is InputEventKey and event.pressed and !event.is_echo():
		if event.keycode == KEY_SPACE:
			if !isSpinning:
				random_spin()
				
signal resetspinComplete

func InterruptSpin(): # Kill any spin that is underway, and maybe leave it alone if it is already resetting
	print("interruptspin")
	canBeStarted = false
	if isResetting:
		print("interrupting during reset")
		await resetspinComplete
		isResetting = false
		spinInterruptComplete.emit()
	elif isSpinning:
		print("spinning, but not resetting")
		spintween.kill()
		isResetting = true
		var manualresettween = get_tree().create_tween()
		#reset_spin()
		var colourtweentime = 0.1*TimeCoefficient
		manualresettween.tween_property(self, "rotation", 0, (ResetTime)*TimeCoefficient).set_trans(Tween.TRANS_SINE)
		manualresettween.tween_property(self, "modulate", Color.from_hsv(0,0,0.3), colourtweentime)
		await manualresettween.finished
		print("manual reset finished")
		isResetting = false
		spinInterruptComplete.emit()
		
	isSpinning = false

func AddExtraWait(extratime):
	ExtraWaitTime+=extratime
func SubtractWaitTime(time):
	SubtractedWaitTime+=time
