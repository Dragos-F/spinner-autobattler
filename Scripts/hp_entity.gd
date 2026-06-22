extends Node2D
class_name HealthEntity
@export var maxhealth:float = 100
@export var currenthealth:float = 100

@export var animator:AnimationPlayer
@export var healthtext:Label
var healthAnimLength:float = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animator.play("hp_progress")
	healthAnimLength = animator.current_animation_length-0.01
	print("healthanimlength"+str(healthAnimLength))
	updateHealthDisplay()
	pass # Replace with function body.

var currentstate:float = -1
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if maxhealth <=0:
		maxhealth = 1
	pass

var isAlive:bool=true

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_A:
			damage(1)
		elif event.keycode == KEY_D:
			heal(1)
		elif event.keycode == KEY_RIGHT:
			position += Vector2(5,0)
		elif event.keycode == KEY_LEFT:
			position += Vector2(-5,0)

	
func changehealth(amount:float)->float:
	currenthealth = currenthealth+amount
	if currenthealth > maxhealth:
		currenthealth = maxhealth
	if currenthealth < 0:
		currenthealth = 0
	updateHealthDisplay()
	return currenthealth
	
func updateHealthDisplay()->void:
	var healthfraction = currenthealth/maxhealth
	if currentstate != healthfraction:
		print("updating health blend to "+str(healthfraction)+":"+str(healthfraction*healthAnimLength))
		animator.speed_scale = 1
		animator.seek(healthfraction*healthAnimLength)
		animator.speed_scale = 0
		currentstate = healthfraction
	if healthtext:
		healthtext.text = str(int(round(currenthealth)))+"/"+str(int(round(maxhealth)))
	pass

func damage(amount:float)->float:
	var endhealth = changehealth(-amount)
	if endhealth == 0:
		print("entity has died")
		isAlive = false
	return endhealth

func heal(amount:float)->float:
	var endhealth = changehealth(amount)
	return endhealth
