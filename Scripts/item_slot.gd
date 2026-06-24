extends Control

class_name ItemSlot

@onready var manager:InvManager
@export var old_anchor:Control
@export var hovering:bool = false

func _ready() -> void:
	manager = %InventoryManager
	
func _process(delta: float) -> void:
	pass


func _on_mouse_entered() -> void:
	hovering = true
	print("Hovering over slot")
	if manager.holding:
		print(manager.held_object)
		
		old_anchor = manager.held_object.anchor_pos
		reset_size_preview(old_anchor)
		manager.held_object.anchor_pos = self
		increase_size_preview(self)
		print(manager.held_object.anchor_pos)
	
func _input(event: InputEvent) -> void:
	if event.is_action_released("MouseLeft"):
		reset_size_preview(self)
func _on_mouse_exited() -> void:
	hovering = false
	
func increase_size_preview(target:Control):
	target.scale += Vector2(0.1,0.1)
	
func reset_size_preview(target:Control):
	target.scale = Vector2.ONE
	
	
