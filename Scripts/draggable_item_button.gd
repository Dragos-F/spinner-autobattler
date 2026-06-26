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

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if item.icon !=null:
		self.icon = item.icon
	else:
		self.icon = preload("uid://5j4kojdswfcv")
	expand_icon = true

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
		disabled = true
		var target = get_global_mouse_position()
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position",target,0.1)
	elif (self.global_position - anchor_pos.global_position).length() >= Vector2(1,1).length():
		#print(anchor_pos.position)
		reset_location()


func _gui_input(event: InputEvent) -> void:
	
	if hovering:		
		if event.is_action_pressed("MouseLeft"):
			dragging = true
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
