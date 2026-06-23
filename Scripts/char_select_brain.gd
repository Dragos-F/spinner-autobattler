extends Node

@export var CharFront:TextureRect
@export var CharBack:TextureRect
@export var CharName:Label
@export var CharDesc:Label
@export var DemoWheel:Wheel



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func show_selected_starter(starter:int, display_name:String, Description:String, char_front:Texture2D, char_back:Texture2D, item:WheelItem):
	CharFront.texture = char_front
	CharBack.texture = char_back
	CharName.text = display_name
	CharDesc.text = Description
	DemoWheel.item = item
	DemoWheel.UpdateWheel(item)
	
