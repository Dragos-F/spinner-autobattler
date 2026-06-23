extends Node

@export var EnemyDisplay:TextureRect
@export var EnemyTitleText:Label
@export var EnemyDescriptionText:Label

@export var EnemyCollections:Array[EnemyCollection]
@export var ActiveEnemyCollection:int=0
@export var PrimaryEnemyWheel:Wheel
var StageNumber:int=0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LoadRandomEnemy()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func LoadRandomEnemy():
	print("loadrandomenemy")
	var currentcollection = EnemyCollections[ActiveEnemyCollection]
	LoadEnemy(currentcollection.Contents.pick_random())

var ActiveEnemy

func LoadEnemy(enemy:Enemy):
	print("loadenemy")
	ActiveEnemy = enemy
	PrimaryEnemyWheel.UpdateWheel(enemy.Items[0])
	EnemyTitleText.text = enemy.Name
	EnemyDescriptionText.text = enemy.Description
	EnemyDisplay.texture = enemy.Graphic
	
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and !event.is_echo():
		if event.keycode == KEY_P:
			LoadRandomEnemy()
	
