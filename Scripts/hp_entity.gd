extends Node2D

@export var maxhealth:float = 100
@export var currenthealth:float = 100

@export var animator:AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animator.play("hp_progress")
	pass # Replace with function body.

var currentstate:float = -1
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if maxhealth <=0:
		maxhealth = 1
	var healthfraction = currenthealth/maxhealth
	if currentstate != healthfraction:
		print("updating health blend to "+str(healthfraction))
		animator.speed_scale = 1
		animator.seek(healthfraction)
		animator.speed_scale = 0
		currentstate = healthfraction
	pass
	
func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_A:
			if currenthealth-1<0:
				currenthealth = 0
			else:
				currenthealth = currenthealth -1
		elif event.keycode == KEY_D:
			if currenthealth+1 > maxhealth:
				currenthealth = maxhealth
			else:
				currenthealth = currenthealth+1
		elif event.keycode == KEY_RIGHT:
			position += Vector2(5,0)
		elif event.keycode == KEY_LEFT:
			position += Vector2(-5,0)
