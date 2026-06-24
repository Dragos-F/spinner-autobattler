extends Control

class_name ItemSlot

@export_category("Item Interactions")
@onready var manager:InvManager
@export var old_anchor:Control
@export var equipped_item:Draggable
@export var hovering:bool = false

@export_category("Wheel Info")
@export var slot_number:int



func _ready() -> void:
	manager = %InventoryManager
	equipped_item = null
	
func _process(delta: float) -> void:
	pass


func _on_mouse_entered() -> void:
	hovering = true
	print("Hovering over slot")
	if manager.holding:
		#print(manager.held_object.item)
		old_anchor = manager.held_object.anchor_pos
		reset_size_preview(old_anchor)
		old_anchor.equipped_item = null
		equipped_item = manager.held_object
		manager.held_object.anchor_pos = self
		increase_size_preview(self)
		#print(manager.held_object.anchor_pos)
		#print(manager.held_object.item)
	
func _input(event: InputEvent) -> void:
	if event.is_action_released("MouseLeft"):
		reset_size_preview(self)
		manager.update_wheels()

func _on_mouse_exited() -> void:
	hovering = false
	
func increase_size_preview(target:Control):
	target.scale += Vector2(0.1,0.1)
	
func reset_size_preview(target:Control):
	target.scale = Vector2.ONE
	
	
