extends Button
class_name Draggable


@export var item:WheelItem
@export var hovering:bool
@export var dragging:bool
@export var anchor_pos:ItemSlot #Mainly used for the ransform coords for the object to return to when not holding

@export var hold_time_delta:float
@onready var manager:InvManager
@onready var once:bool = true
@onready var reset:bool = true


@export var tooltipObject:ItemTooltip
@export var displayoffsets:Vector2 = Vector2(50,50)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if item.icon !=null:
		self.icon = item.icon
	else:
		self.icon = preload("uid://5j4kojdswfcv")
	expand_icon = true
	print (tooltipObject)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dragging:
		hold_time_delta+=delta
	if hold_time_delta>0.2:
		if once:
			manager.holding = true
			manager.held_object = self
			once = false
			self.mouse_filter = Control.MOUSE_FILTER_PASS
			hideToolTip()
		disabled = true
		var target = get_global_mouse_position()
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position",target,0.1)
	elif (self.global_position - anchor_pos.global_position).length() >= Vector2(1,1).length():
		#print(anchor_pos.position)
		reset_location()


func _gui_input(event: InputEvent) -> void:
	#if activeTooltip != null:
		#hideToolTip()
		#print("ToolTip hidden")
	if hovering:		
		if event.is_action_pressed("MouseLeft") && !event.is_echo():
			dragging = true
			if tooltipObject.visible == false:
				print("tooltip Shown")
				showToolTip()
			else:
				print ("hiding tooltip")
				hideToolTip()
	if event.is_action_released("MouseLeft"):
		dragging = false
		hold_time_delta = 0 
		disabled = false
		once = true
		manager.holding = false
		manager.held_object = null
		print("DELETING")
		print (manager.held_object)
		#self.mouse_filter = Control.MOUSE_FILTER_STOP
	
		
func reset_location():
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position",anchor_pos.global_position,0.3)
		#print (anchor_pos)
		
func _on_mouse_entered() -> void:
	#print("hovering")
	hovering = true


func _on_mouse_exited() -> void:
	#print("left")
	hovering = false


func _on_pressed() -> void:
	print("pressed")


func showToolTip():
	if tooltipObject.visible == false:
		print("creating tooltip")
	
		tooltipObject.item_icon.texture = item.icon
		tooltipObject.item_name.text = item.name
		tooltipObject.item_desc.text = item.Desc
		tooltipObject.item_stats.UpdateWheel(item)
		var camera = get_viewport().get_camera_2d()
		var pos: Vector2 = camera.global_position
		#pos = offsetPosition(global_position,pos)
		tooltipObject.position = pos
		tooltipObject.visible = true
	pass
	
func hideToolTip():
	if tooltipObject.visible == true:
		print("hiding/destroying tooltip")
		tooltipObject.visible = false
		
	pass
#func offsetPosition(rootpos,inputpos):
	#var newpos = inputpos
	#if rootpos.x > newpos.x: # if slice is further to right than mouse
		#newpos.x -= displayoffsets.x
	#elif rootpos.x <= newpos.x:
		#newpos.x += displayoffsets.x
	#if rootpos.y > newpos.y:
		#newpos.y -= displayoffsets.y
	#elif rootpos.y <= newpos.y:
		#newpos.y += displayoffsets.y
	#return newpos
