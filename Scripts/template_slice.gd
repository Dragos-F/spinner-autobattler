@tool
extends Polygon2D
class_name PresetSlice


@export var own_collision:CollisionPolygon2D
@export var collision_color:PackedColorArray
@export var tooltipObject:PackedScene
@onready var slice_type:Slice
func _ready() -> void:
	pass
	
func new_shape(o:Vector2,a:Vector2, b:Vector2):
	own_collision.polygon = [o,a,b]
@export var displayoffsets:Vector2 = Vector2(50,50)
var activeTooltip
func showToolTip():
	if activeTooltip == null:
		print("creating tooltip")
		var instance = tooltipObject.instantiate()
		get_tree().root.add_child(instance)
		instance.get_child(0).text = slice_type.tooltip
		var camera = get_viewport().get_camera_2d()
		var pos: Vector2 = camera.get_global_mouse_position()
		pos = offsetPosition(global_position,pos)
		activeTooltip = instance
		activeTooltip.position = pos
	pass
	
func hideToolTip():
	if activeTooltip != null:
		print("hiding/destroying tooltip")
		activeTooltip.queue_free()
	pass
func offsetPosition(rootpos,inputpos):
	var newpos = inputpos
	if rootpos.x > newpos.x: # if slice is further to right than mouse
		newpos.x -= displayoffsets.x
	elif rootpos.x <= newpos.x:
		newpos.x += displayoffsets.x
	if rootpos.y > newpos.y:
		newpos.y -= displayoffsets.y
	elif rootpos.y <= newpos.y:
		newpos.y += displayoffsets.y
	return newpos
func _input(event: InputEvent) -> void:
	if event is InputEventMouse:
		var camera = get_viewport().get_camera_2d()
		var pos: Vector2 = camera.get_global_mouse_position()
		if activeTooltip != null:
			print("Mouse at: ", pos)
			pos = offsetPosition(global_position,pos)
			activeTooltip.position = pos

func _on_area_2d_mouse_entered() -> void:
	print ("Hovering"+str(slice_type))
	showToolTip()
	pass

func _on_area_2d_mouse_exited() -> void:
	print ("Left"+str(slice_type))
	hideToolTip()
	pass
