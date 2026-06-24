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
			PlayerEntity.damage(slice.value)
		"Jackpot":
			PlayerEntity.damage(slice.value)
		"Backfire":
			PlayerEntity.damage(slice.value)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
