extends Node

@export var CharFront:TextureRect
@export var CharBack:TextureRect
@export var CharName:Label
@export var CharDesc:Label
@export var DemoWheel:Wheel
@export var item_drag:Draggable
@export var inv:InvManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	item_drag.manager = inv


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func show_selected_starter(starter:int, display_name:String, Description:String, char_front:Texture2D, char_back:Texture2D, item:WheelItem):
	CharFront.texture = char_front
	CharBack.texture = char_back
	CharName.text = display_name
	CharDesc.text = Description
	#DemoWheel.item = item
	item_drag.item = item
	item_drag.icon = item.icon
	#DemoWheel.UpdateWheel(item)


func _on_GO_pressed() -> void:
	GlobalChar.char_front=CharFront.texture
	GlobalChar.char_back=CharBack.texture
	GlobalChar.char_name = CharName.text
	GlobalChar.starting_item = item_drag.item
	Fader.FadeUp("")
	await Fader.fade_finished
	get_tree().change_scene_to_file("res://Scenes/MainScene.tscn")
	Fader.FadeDown("")
