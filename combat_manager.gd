extends Node
class_name CombatManager

@export var PlayerEntity:HealthEntity
@export var EnemyEntity:HealthEntity
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func listen_enemy_spinresult(slice:PresetSlice,source:String):
	var name: String = slice.slice_type.resource_path
	name = name.trim_prefix("res://Resources/Slices/")
	name = name.trim_suffix(".tres")
	print("Enemy Spin from "+source)
	print(name)
	match name:
		"Hit":
			PlayerEntity.damage(slice.slice_type.value)
		"Jackpot":
			PlayerEntity.damage(slice.slice_type.value)
		"Backfire":
			EnemyEntity.damage(slice.slice_type.value)
		"Fix":
			EnemyEntity.heal(slice.slice_type.value)
	pass


func listen_player_spinresult(slice:PresetSlice,source:String):
	var name: String = slice.slice_type.resource_path
	name = name.trim_prefix("res://Resources/Slices/")
	name = name.trim_suffix(".tres")
	print("Player Spin from "+source)
	print(name)
	match name:
		"Hit":
			EnemyEntity.damage(slice.slice_type.value)
		"Jackpot":
			EnemyEntity.damage(slice.slice_type.value)
		"Backfire":
			PlayerEntity.damage(slice.slice_type.value)
		"Fix":
			PlayerEntity.heal(slice.slice_type.value)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
