extends Node

@export var EnemyDisplay:TextureRect

@export var EnemyCollections:Array[EnemyCollection]
@export var ActiveEnemyCollection:int=0
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
	
func LoadEnemy(enemy:Enemy):
	print("loadenemy")
	EnemyDisplay.texture = enemy.Graphic
