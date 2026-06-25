extends Control

class_name ItemSlot

enum Type {Loot,Inv,Bin}
@export_category("Item Interactions")
@onready var manager:InvManager
@export var old_anchor:Control
@export var equipped_item:Draggable
@export var hovering:bool = false
<<<<<<< Updated upstream
@export var once:bool = true
@export var type:Type
=======
>>>>>>> Stashed changes

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
<<<<<<< Updated upstream
	if event.is_action_released("MouseLeft") and !event.is_echo():
		if hovering:
			if manager.held_object!=null:
				if manager.held_object.item.isUpgrade && equipped_item != null:
					manager.add_upgrade(self,manager.held_object.item)
					manager.held_object.queue_free()
				if type == Type.Bin:
					manager.holding = false
					manager.held_object.queue_free()
					equipped_item = null
			reset_size_preview(self)
			manager.update_wheels()
			if type == Type.Inv:
				manager.loot_sys._on_skip_loot_pressed()
			
	
=======
	if event.is_action_released("MouseLeft"):
		reset_size_preview(self)
		manager.update_wheels()
>>>>>>> Stashed changes

func _on_mouse_exited() -> void:
	hovering = false
	
func increase_size_preview(target:Control):
	target.scale += Vector2(0.1,0.1)
	
func reset_size_preview(target:Control):
	target.scale = Vector2.ONE
	
<<<<<<< Updated upstream
func reassign_anchor():
		if equipped_item == null or manager.held_object.item.isUpgrade && equipped_item != null:
			old_anchor = manager.held_object.anchor_pos
			reset_size_preview(old_anchor)
			if self != old_anchor:
				old_anchor.equipped_item = null
			if !manager.held_object.item.isUpgrade:
				equipped_item = manager.held_object
			manager.held_object.anchor_pos = self
			if type == Type.Inv:
				if equipped_item !=null:
					equipped_item.set_pivot_offset(Vector2(12,12))
					print (equipped_item.offset_transform_pivot)
					
			if type == Type.Loot:
				if equipped_item !=null:
					equipped_item.set_pivot_offset(Vector2(64,41))
			increase_size_preview(self)
		#print ("EQUIPPED " +str(equipped_item))
		#print(manager.held_object.anchor_pos)
		#print(manager.held_object.item)
=======
	
>>>>>>> Stashed changes
