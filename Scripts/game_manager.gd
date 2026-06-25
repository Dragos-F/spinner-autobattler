extends Node

@export var EnemyDisplay:TextureRect
@export var EnemyTitleText:Label
@export var EnemyDescriptionText:Label
@export var EnemyHPSystem:HealthEntity

@export var EnemyCollections:Array[EnemyCollection]
@export var EnemyCollectionBounds:Array[Vector2]
@export var ActiveEnemyCollection:int=0
@export var PrimaryEnemyWheel:Wheel
@export var PrimaryEnemySpinner:Spinner

@export var combatManager:CombatManager
var StageNumber:int=0
var PlayerScore:int=0

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
var ActiveEnemyHP
func LoadEnemy(enemy:Enemy):
	print("loadenemy")
	ActiveEnemy = enemy
	PrimaryEnemyWheel.UpdateWheel(enemy.Items[0])
	EnemyTitleText.text = enemy.Name
	EnemyDescriptionText.text = enemy.Description
	EnemyDisplay.texture = enemy.Graphic
	ActiveEnemyHP = enemy.BaseHealth
	EnemyHPSystem.currenthealth = enemy.BaseHealth
	EnemyHPSystem.maxhealth = enemy.BaseHealth
	
	EnemyHPSystem.isAlive = true
	combatManager.EnemyEntity = EnemyHPSystem
	PrimaryEnemySpinner.modulate = Color.from_hsv(0,0,1)
	EnemyDisplay.modulate = Color.from_hsv(0,0,1)

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and !event.is_echo():
		if event.keycode == KEY_P:
			LoadRandomEnemy()
		elif event.keycode == KEY_G:
			if PreparedToReset:
				PrimaryEnemySpinner.canBeStarted = true				
				LoadRandomEnemy()
				PrimaryEnemySpinner.random_spin()
				PreparedToReset = false

var PreparedToReset=false

func _listener_entityDied(he:HealthEntity):
	print("entitydied")
	if he == EnemyHPSystem:
		print("active enemy has been killed")
		AddPoints(100)
		PrimaryEnemySpinner.modulate = Color.from_hsv(0,0,0.2)
		PrimaryEnemySpinner.canBeStarted = false
		EnemyDisplay.modulate = Color.from_hsv(0,0,0.2)
		GameProgressProcedure()
	elif he == combatManager.PlayerEntity:
		print("player has been killed")
	return

func GameProgressProcedure():
	print("progressing to next encounter")
	StageNumber+=1
	var collectionindex = 0
	for er in EnemyCollectionBounds:
		if StageNumber >= er.x and StageNumber <= er.y:
			print("now using enemy collection "+ str(collectionindex))
			ActiveEnemyCollection = collectionindex
			break
		collectionindex+=1
		
	# LOOT PHASE HERE
	
	#LoadRandomEnemy()
	PreparedToReset = true
	pass

func AddPoints(amount:int):
	print("earned "+str(amount)+" points")
	PlayerScore+=amount

func _listener_enemydamaged(healthE:HealthEntity,delta):
	AddPoints(int(ceil(delta)))
	pass
