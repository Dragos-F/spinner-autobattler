extends Node


@export var maxhealth:float = 100
@export var currenthealth:float = 100

@export var animator:AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var currentstate:float = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if maxhealth <=0:
		maxhealth = 1
	var healthfraction = currenthealth/maxhealth
	if currentstate != healthfraction:
		print("updating health blend to "+str(healthfraction))
		animator.seek(healthfraction,true)
		currentstate = healthfraction
	pass
	

func _input(event):
	if event is InputEventKey and event.pressed and !event.is_echo():
		if event.keycode == KEY_A:
			currenthealth = currenthealth -1
			if currenthealth<0:
				currenthealth = 0
		elif event.keycode == KEY_D:
			currenthealth = currenthealth+1
			if currenthealth > maxhealth:
				currenthealth = maxhealth
