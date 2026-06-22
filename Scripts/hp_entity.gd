extends Node2D

@export var maxhealth:float = 100
@export var currenthealth:float = 100

@export var animator:AnimationPlayer
@export var healthtext:Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animator.play("hp_progress")
	updateHealthDisplay()
	animator.speed_scale = 0
	pass # Replace with function body.

var currentstate:float = -1
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if maxhealth <=0:
		maxhealth = 1
	pass
	
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
			
func damage(amount:float)->float:
	var endhealth = changehealth(-amount)
	return endhealth
	
func heal(amount:float)->float:
	var endhealth = changehealth(amount)
	return endhealth
	
func changehealth(amount:float)->float:
	currenthealth = currenthealth+amount
	if currenthealth > maxhealth:
		currenthealth = maxhealth
	if currenthealth < 0:
		currenthealth = 0
	updateHealthDisplay()
	return currenthealth
	
func updateHealthDisplay()->void:
	if healthtext:
		healthtext.text = str(int(round(currenthealth)))+"/"+str(int(round(maxhealth)))
	var healthfraction = currenthealth/maxhealth
	if currentstate != healthfraction:
		print("updating health blend to "+str(healthfraction))
		animator.speed_scale = 1
		animator.seek(healthfraction)
		animator.speed_scale = 0
		currentstate = healthfraction
	pass
