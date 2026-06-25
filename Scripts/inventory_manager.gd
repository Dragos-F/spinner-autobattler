extends Node
class_name InvManager


@export var holding:bool
@export var held_object:Draggable
@export var slots:Array[ItemSlot]
@export var wheels:Array[Wheel]
@export var loot_sys:LootSystem

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
			
func add_upgrade(targetSlot:ItemSlot,upgrade:WheelItem):
	print ("UPGRADE")
	if slots.find(targetSlot) != -1:
		var target_index = slots.find(targetSlot)
		print (target_index)
		print ("EQUIPPED "+str(slots[target_index].equipped_item))
		slots[target_index].equipped_item.item = slots[target_index].equipped_item.item.duplicate(true)
		
		if slots[target_index].equipped_item.item.stats.size() >=12:
			for i in upgrade.stats.size():
				slots[target_index].equipped_item.item.stats.remove_at(randi()%slots[target_index].equipped_item.item.stats.size()-1)
		slots[target_index].equipped_item.item.stats.append_array(upgrade.stats)
		#wheels[target_index].UpdateWheel(slots[target_index].equipped_item.item)
		
