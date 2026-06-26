extends Control

@export var tutorial:PanelContainer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_character_triangle_inner_pressed() -> void:
	tutorial.visible = true


func _on_button_pressed() -> void:
	tutorial.visible = false
	
func _on_mouse_entered() -> void:
	print ("Moused Over")
	scale = Vector2(1.1,1.1)


func _on_mouse_exited() -> void:
	print ("Mouse Left")
	scale = Vector2.ONE
