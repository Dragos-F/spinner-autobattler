@tool
extends Polygon2D
class_name PresetSlice


@export var own_collision:CollisionPolygon2D
@export var collision_color:PackedColorArray
@onready var slice_type:Slice
func _ready() -> void:
	pass
	
func new_shape(o:Vector2,a:Vector2, b:Vector2):
	own_collision.polygon = [o,a,b]



func _on_area_2d_mouse_entered() -> void:
	#print ("Hovering"+str(slice_type))
	pass


func _on_area_2d_mouse_exited() -> void:
	#print ("Left"+str(slice_type))
	pass
