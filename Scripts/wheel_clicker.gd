extends Node2D
class_name Clicker


@export var final_slice:PresetSlice
@export var result:Label
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass




func _on_area_2d_area_entered(area: Area2D) -> void:
	var temp_slice = area.get_parent()
	#print(temp_slice)
	final_slice = temp_slice

func select_slice():
	if final_slice !=null:
		var name: String = final_slice.slice_type.resource_path
		name = name.trim_prefix("res://Resources/Slices/")
		name = name.trim_suffix(".tres")
		result.text = "Selected Slice: "+name
		#print (name)
	
	
func reset_text():
	await get_tree().create_timer(1.5).timeout
	result.text = "Resetting"
	
func spining_text():
	result.text = "Spinning"
