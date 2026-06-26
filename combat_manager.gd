extends Node
class_name CombatManager

@export var PlayerEntity:HealthEntity
@export var PlayerSpinners:Array[Spinner]
@export var EffectAlertLabel:PackedScene

@export var EnemyEntity:HealthEntity
@export var EnemySpinners:Array[Spinner]
@export var InventorySys:InvManager
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func listen_enemy_spinresult(slice:PresetSlice,source:String):
	var name: String = slice.slice_type.resource_path
	name = name.trim_prefix("res://Resources/Slices/")
	name = name.trim_suffix(".tres")
	print("Enemy Spin from "+source)
	print(name)
	ProcessResult(name,slice,EnemyEntity,PlayerEntity,EnemySpinners,PlayerSpinners)

func ProcessResult(name,slice,sourceEntity,targetEntity,sourceWheels,targetWheels):
	if slice.isDisabled:
		print("...slice is disabled, ignoring")
		return
	match name:
		"Hit":
			targetEntity.damage(slice.slice_type.value)
			spawn_effect_label("HIT!",slice)
		"Jackpot":
			targetEntity.damage(slice.slice_type.value)
			spawn_effect_label("JACKPOT!!",slice)
		"Backfire":
			sourceEntity.damage(abs(slice.slice_type.value))
			spawn_effect_label("BACKFIRE!",slice,"float_down")
		"Fix":
			sourceEntity.heal(slice.slice_type.value)
			spawn_effect_label("FIX!",slice,"float_down")
		"Stumble":
			DelayFromSet(sourceWheels,slice.slice_type.modifier)
			spawn_effect_label("STUMBLE!",slice,"float_down")
		"Stall":
			DelayFromSet(sourceWheels,slice.slice_type.modifier)
			spawn_effect_label("STALL!",slice)
		"Rush":
			AccelerateFromSet(sourceWheels,slice.slice_type.modifier)
			spawn_effect_label("RUSH!",slice,"float_down")
		"Stun":
			StunAllWheelsInSet(targetWheels,slice.slice_type.power)
			spawn_effect_label("STUN!",slice)
			#StunWheelInSet(targetWheels,slice.slice_type.power)
	pass

func spawn_effect_label(text,sliceobj,atag="float_up",colour:Color = Color.TRANSPARENT):
		var instance = EffectAlertLabel.instantiate()
		get_tree().root.add_child(instance)
		instance.get_child(0).text = text
		if colour == Color.TRANSPARENT:
			instance.modulate = sliceobj.slice_type.colour
		else:
			instance.modulate = colour
		instance.global_position = sliceobj.global_position*0.5
		var animr:AnimationPlayer = instance.get_child(0).get_child(0)
		animr.play(atag)
		await animr.animation_finished
		instance.queue_free()
	

func listen_player_spinresult(slice:PresetSlice,source:String):
	var name: String = slice.slice_type.resource_path
	name = name.trim_prefix("res://Resources/Slices/")
	name = name.trim_suffix(".tres")
	print("Player Spin from "+source)
	print(name)
	ProcessResult(name,slice,PlayerEntity,EnemyEntity,PlayerSpinners,EnemySpinners)
	
func DelayFromSet(wheelSet:Array[Spinner],coeff:float):
	for spinnr in wheelSet:
		if spinnr.visible:
			var wheelAmnt = spinnr.ResetTime*(coeff-1);
			spinnr.AddExtraWait(wheelAmnt)
		
func AccelerateFromSet(wheelSet:Array[Spinner],coeff:float):
	for spinnr in wheelSet:
		if spinnr.visible:
			var wheelAmnt = spinnr.ResetTime*coeff;
			spinnr.SubtractWaitTime(wheelAmnt)

func StunWheelInSet(wheelSet:Array[Spinner],count:int):
	var activeWheelSet = []
	for aw in wheelSet:
		if aw.get_parent().visible and aw.canBeStarted:
			print("wheel "+ str(aw) + " is visible and startable")
			activeWheelSet.append(aw)
	if len(activeWheelSet) == 0:
		print("no available wheels")
		return
	var randomwheel = activeWheelSet.pick_random()
	randomwheel.wheel.DisableRandomSlices(count,10)

func StunAllWheelsInSet(wheelSet:Array[Spinner],count:int):
	for aw in wheelSet:
		if aw.get_parent().visible and aw.canBeStarted:
			print("wheel "+ str(aw) + " is visible and startable")
			aw.wheel.DisableRandomSlices(count,10)


func _on_heal_skip_pressed() -> void:
	PlayerEntity.changehealth(100)
