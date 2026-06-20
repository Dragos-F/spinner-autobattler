extends Node2D
class_name Wheel


@export var item:WheelItem
@export var wheel_size:int
@export var test_colors:Array[Color]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var slice_parent = Node2D.new()
	var temp_slice = Polygon2D.new()
	slice_parent.add_child(temp_slice)
	#wheel_size = item.stats.size()	
	var angle = 2*PI/wheel_size
	print ("Angle:"+str(angle))
	var a = Vector2(0,-10)
	var bx:float
	var by:float
	
	by = (pow(a.length(),2)*cos(angle))/a.y
	print (by)
	bx = sqrt(pow(a.length(),2)-(pow(by,2)))
	print (bx)
	var b = Vector2(bx,by)
	print (b.angle_to(a))
	temp_slice.polygon = [position,a,b]
	temp_slice.scale = Vector2(10,10)
	
	for i in wheel_size:
		print("Iterated once")
		var new_temp_slice = slice_parent.duplicate()
		var new_polygon = new_temp_slice.get_child(0)
		if new_polygon is Polygon2D:
			if i<test_colors.size():
				new_polygon.color = test_colors[i]
			else:
				new_polygon.color = test_colors[wheel_size-i]
		add_child(new_temp_slice)
		new_temp_slice.rotate(angle*(i+1))
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
