extends Node

@export var button_parent:Node2D
@export var items:Array[Draggable]
@export var item_manager:InvManager


# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	for i in button_parent.get_children():
		if i is Draggable:
			items.append(i)
			i.manager = item_manager


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
