extends Control

class_name LootSystem

@export var option_slots:Array[ItemSlot]
@export var options: Array[Draggable] 
@export var pool:LootPool
@export var manager:InvManager
@export var heal_button:Button
@export var heal_percent:float
@export var item_tooltip: ItemTooltip

signal loot_ended()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	options.resize(option_slots.size())
	#spawn_options()
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func generate_random_loot() -> WheelItem:
	var rng = RandomNumberGenerator.new()
	return pool.LootTable.keys()[rng.rand_weighted(pool.LootTable.values())]

func spawn_options():
	options.clear()
	options.resize(option_slots.size())
	if randf_range(0,100) < heal_percent:
		heal_button.visible = true
	else:
		heal_button.visible = false
	visible = true
	for i in option_slots.size():
		var scene = load("res://Scenes/draggable_item.tscn")
		options[i] = scene.instantiate()
		get_tree().current_scene.add_child.call_deferred(options[i])
		options[i].anchor_pos = option_slots[i]
		option_slots[i].equipped_item = options[i]
		options[i].manager = manager
		options[i].tooltipObject = item_tooltip
		options[i].item = generate_random_loot()
		options[i].set_pivot_offset(Vector2(22,40))
		#print (options[i].item)

	


func _on_skip_loot_pressed() -> void:
	print ("Ended Loot")
	self.visible = false
	for i in option_slots.size():
		if option_slots[i].equipped_item != null:
			option_slots[i].equipped_item.queue_free()
	loot_ended.emit()

func check_loot_taken():
	var item_taken:bool = false
	for i in option_slots.size():
		print ("CHECKED LOOT OPTIONS"+str(option_slots[i].equipped_item))
		if option_slots[i].equipped_item == null:
			item_taken = true
	if item_taken:
		_on_skip_loot_pressed()
