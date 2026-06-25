extends Node
class_name CombatManager

@export var PlayerEntity:HealthEntity
@export var PlayerSpinners:Array[Spinner]


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
		"Jackpot":
			targetEntity.damage(slice.slice_type.value)
		"Backfire":
			sourceEntity.damage(slice.slice_type.value)
		"Fix":
			sourceEntity.heal(slice.slice_type.value)
		"Stumble":
			DelayFromSet(sourceWheels,slice.slice_type.modifier)
		"Stall":
			DelayFromSet(sourceWheels,slice.slice_type.modifier)
		"Rush":
			AccelerateFromSet(sourceWheels,slice.slice_type.modifier)
		"Stun":
			StunWheelInSet(targetWheels,slice.slice_type.power)
	pass

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
		if aw.visible and aw.canBeStarted:
			print("wheel is invisible, skipping")
			#activeWheelSet.append(aw)
	if len(activeWheelSet) == 0:
		print("no available wheels")
		return
	var randomwheel = activeWheelSet.pick_random()
	randomwheel.wheel.DisableRandomSlices(count,20)
