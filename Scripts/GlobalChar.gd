extends Node

var char_front:Texture2D
var char_back:Texture2D
var char_name:String
enum Starters{
	Pete=1,
	Rory=2,
	Timmy=3,
	Zombolda=4,
	Dane=5,
	Hornacia=6
}
var chararacter:Starters
var starting_item:WheelItem
var playerscore:int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(starting_item)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
