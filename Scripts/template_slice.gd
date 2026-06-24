@tool
extends Polygon2D
class_name PresetSlice


@export var own_collision:CollisionPolygon2D
@export var collision_color:PackedColorArray
@onready var tooltipObject:PackedScene
@onready var slice_type:Slice
func _ready() -> void:
	pass
	
func new_shape(o:Vector2,a:Vector2, b:Vector2):
	own_collision.polygon = [o,a,b]

var activeTooltip
func showToolTip():
	if activeTooltip == null:
		print("creating tooltip")
		var instance = tooltipObject.instantiate()
		add_child(instance)
		activeTooltip = instance
	pass
	
func hideToolTip():
	if activeTooltip != null:
		print("hiding/destroying tooltip")
		activeTooltip.queue_free()
	pass

func _on_area_2d_mouse_entered() -> void:
	print ("Hovering"+str(slice_type))
	showToolTip()
	pass


func _on_area_2d_mouse_exited() -> void:
	print ("Left"+str(slice_type))
	hideToolTip()
	pass
