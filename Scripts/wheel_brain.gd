@tool
extends Node2D
class_name Wheel


@export var item:WheelItem
@onready var wheel_size:int
@export var wheel_scale = Vector2(10,10)
@export var slice_template:PresetSlice

var slice_parent
var temp_slice:PresetSlice
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#slice_parent = get_parent()
	if item == null:
		print("no item assigned")
	else:
		generatewheel()
		"""
		wheel_size = item.stats.size()
		var angle = 2*PI/wheel_size
		#print ("Angle:"+str(angle))
		var a = Vector2(0,-10)
		var bx:float
		var by:float
		
		by = (pow(a.length(),2)*cos(angle))/a.y
		#print (by)
		bx = sqrt(pow(a.length(),2)-(pow(by,2)))
		#print (bx)
		var b = Vector2(bx,by)
		#print (b.angle_to(a))
		temp_slice.polygon = [position,a,b]
		temp_slice.new_shape(position, a, b)
		temp_slice.scale = wheel_scale
		
		for i in wheel_size: #ITERATION WHERE YOU CAN MODIFY THE SLICE BEFORE IT'S MADEE
			var perm_slice = slice_parent.duplicate()
			add_child(perm_slice)
			perm_slice.rotate(angle*(i+1))
			var copied_slice:PresetSlice = perm_slice.get_child(0)
			copied_slice.slice_type = item.stats[i] #bit roundabout, but seemingly the duplication would not copy the resource with it so now we're heree
			if item.stats[i].visual !=null:
				copied_slice.texture = item.stats[i].visual
			else:
				copied_slice.color = item.stats[i].colour
			"""
			#print("Iterated once")
			#var new_temp_slice = slice_parent.duplicate()
			#var new_polygon = new_temp_slice.get_child(0)
			#new_polygon.color = item.stats[i].colour
			#add_child(new_temp_slice)
			#new_temp_slice.rotate(angle*(i+1))
func UpdateWheel(newitem:WheelItem):
	item = newitem
	generatewheel()
	pass
	
	
func generatewheel():
	if slice_parent == null:
		slice_parent = Node2D.new()
	else:
		print("slice parent already exists, purging")
		for n in get_children():
			print(n)
			if n == get_child(0):
				continue
			else:
				remove_child(n)
				n.queue_free()
		slice_parent.queue_free()
		slice_parent = Node2D.new()
	temp_slice = slice_template.duplicate()
	slice_parent.add_child(temp_slice)
	wheel_size = item.stats.size()
	var angle = 2*PI/wheel_size
	#print ("Angle:"+str(angle))
	var a = Vector2(0,-10)
	var bx:float
	var by:float
	
	by = (pow(a.length(),2)*cos(angle))/a.y
	#print (by)
	bx = sqrt(pow(a.length(),2)-(pow(by,2)))
	#print (bx)
	var b = Vector2(bx,by)
	#print (b.angle_to(a))
	temp_slice.polygon = [position,a,b]
	temp_slice.new_shape(position, a, b)
	temp_slice.scale = wheel_scale
	
	for i in wheel_size: #ITERATION WHERE YOU CAN MODIFY THE SLICE BEFORE IT'S MADEE
		var perm_slice = slice_parent.duplicate()
		add_child(perm_slice)
		perm_slice.rotate(angle*(i+1))
		var copied_slice:PresetSlice = perm_slice.get_child(0)
		copied_slice.slice_type = item.stats[i] #bit roundabout, but seemingly the duplication would not copy the resource with it so now we're heree
		if item.stats[i].visual !=null:
			copied_slice.texture = item.stats[i].visual
		else:
			copied_slice.color = item.stats[i].colour
		print (slice_parent)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
