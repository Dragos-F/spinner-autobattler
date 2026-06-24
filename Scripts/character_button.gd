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

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#ONLY FOR TESTING
	#CharFront = get_child(0).get_child(0).texture
	#CharBack = get_child(0).get_child(0).texture
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if moused_over:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && once:
			selected.emit(Starter,DisplayName,Description,CharFront,CharBack,StartingItem)
			once = false

func _input(event: InputEvent) -> void:
	if event.is_action_released("MouseLeft"):
		once = true


func _on_character_triangle_inner_mouse_entered() -> void:
	moused_over = true
	print ("Moused Over")
	scale = Vector2(1.1,1.1)


func _on_character_triangle_inner_mouse_exited() -> void:
	moused_over = false
	print ("Mouse Left")
	scale = Vector2.ONE
