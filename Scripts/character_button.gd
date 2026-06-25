extends Control

enum Starters{
	Pete=1,
	Rory=2,
	Timmy=3,
	Zombolda=4,
	Dane=5,
	Hornacia=6	
}
@export var Starter:Starters
@export var DisplayName:String
@export_multiline var Description:String
@export var CharFront:Texture2D
@export var CharBack:Texture2D
@export var StartingItem:WheelItem
@onready var moused_over:bool = false
signal selected(starter:Starters,
display_name:String,
Description:String,
CharFront:Texture2D,
CharBack:Texture2D,
item:WheelItem,)

var once:bool = true
@export var own_button:TextureButton
@export var bitmapImage:BitMap

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#ONLY FOR TESTING
	#CharFront = get_child(0).get_child(0).texture
	#CharBack = get_child(0).get_child(0).texture
	own_button.set_click_mask(bitmapImage)
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	pass


func _on_mouse_entered() -> void:
	moused_over = true
	print ("Moused Over")
	scale = Vector2(1.1,1.1)


func _on_mouse_exited() -> void:
	moused_over = false
	print ("Mouse Left")
	scale = Vector2.ONE


func _on_pressed() -> void:
	selected.emit(Starter,DisplayName,Description,CharFront,CharBack,StartingItem)
