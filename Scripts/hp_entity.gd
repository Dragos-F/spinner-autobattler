extends Node2D
class_name HealthEntity
@export var maxhealth:float = 100
@export var currenthealth:float = 100
@export var animationname:String = "hp_progress"

@export var animator:AnimationPlayer
@export var healthtext:Label
@export var CharacterVisualAnimr:AnimationPlayer
var healthAnimLength:float = 1
signal event_hpdepleted(healthE:HealthEntity)
signal event_hpchanged(healthE:HealthEntity,delta)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animator.play(animationname)
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

#func _input(event):
	#if event is InputEventKey and event.pressed:
		#if event.keycode == KEY_A:
			#damage(1)
		#elif event.keycode == KEY_D:
			#heal(1)
		#elif event.keycode == KEY_RIGHT:
			#position += Vector2(5,0)
		#elif event.keycode == KEY_LEFT:
			#position += Vector2(-5,0)

func changehealth(amount:float)->float:
	currenthealth = currenthealth+amount
	if currenthealth > maxhealth:
		currenthealth = maxhealth
	if currenthealth <= 0:
		currenthealth = 0
		isAlive=false
		event_hpdepleted.emit(self)
	event_hpchanged.emit(self,amount)
	updateHealthDisplay()
	return currenthealth
	
func updateHealthDisplay()->void:
	var healthfraction = currenthealth/maxhealth
	if currentstate != healthfraction:
		print("updating health blend to "+str(healthfraction)+":"+str(healthfraction*healthAnimLength))
		animator.speed_scale = 1
		animator.seek(healthfraction*healthAnimLength,true)
		animator.speed_scale = 0
		currentstate = healthfraction
	if healthtext:
		healthtext.text = str(int(round(currenthealth)))+"/"+str(int(round(maxhealth)))
	pass

func damage(amount:float)->float:
	if !isAlive:
		print("no damage, already dead")
		return 0
	var endhealth = changehealth(-amount)
	if CharacterVisualAnimr != null:
		CharacterVisualAnimr.play("damage")
	if endhealth == 0:
		print("entity has died")
		isAlive = false
	return endhealth

func heal(amount:float)->float:
	var endhealth = changehealth(amount)
	return endhealth

func sethealth(amount:float):
	currenthealth = amount
	updateHealthDisplay()
