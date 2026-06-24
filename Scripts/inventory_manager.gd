extends Node
class_name InvManager


@export var holding:bool
@export var held_object:Draggable
@export var slots:Array[ItemSlot]
@export var wheels:Array[Wheel]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_wheels()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_wheels():
	for i in slots.size():
		
		#var temp_item:WheelItem = 
		if slots[i].equipped_item == null:
			wheels[i].get_parent().get_parent().visible = false
		else:
			wheels[i].get_parent().get_parent().visible = true
			wheels[i].UpdateWheel(slots[i].equipped_item.item)
			print("Slot"+str(i)+" Item:"+str(slots[i].equipped_item))
