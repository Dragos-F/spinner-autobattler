extends Node

@export var EnemyDisplay:TextureRect
@export var EnemyTitleText:Label
@export var EnemyDescriptionText:Label
@export var EnemyHPSystem:HealthEntity

@export var EnemyCollections:Array[EnemyCollection]
@export var EnemyCollectionBounds:Array[Vector2]
@export var ActiveEnemyCollection:int=-2
@export var PrimaryEnemyWheel:Wheel
@export var PrimaryEnemySpinner:Spinner

@export var combatManager:CombatManager
var StageNumber:int=-1
var PlayerScore:int=0

var PreparedToStart = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#LoadRandomEnemy()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

var currentEnemyIndex = -1
func LoadNextEnemy():
	print("trying LoadNextEnemy")
	if currentEnemyIndex == -2:
		LoadRandomEnemy()
		return
	currentEnemyIndex+=1
	var currentcollection = EnemyCollections[ActiveEnemyCollection]
	if len(currentcollection.Contents) <= currentEnemyIndex: # if there are not as many items as the desired index
		LoadRandomEnemy()
	else:
		LoadEnemy(currentcollection.Contents[currentEnemyIndex])
	
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
	EnemyHPSystem.isAlive = true
	#EnemyHPSystem.currenthealth = enemy.BaseHealth
	EnemyHPSystem.maxhealth = enemy.BaseHealth
	EnemyHPSystem.sethealth(enemy.BaseHealth)
	
	combatManager.EnemyEntity = EnemyHPSystem
	PrimaryEnemySpinner.modulate = Color.from_hsv(0,0,1)
	EnemyDisplay.modulate = Color.from_hsv(0,0,1)
	

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and !event.is_echo():
		if event.keycode == KEY_G:
			if PreparedToReset:
				PrimaryEnemySpinner.canBeStarted = true
				LoadNextEnemy()
				PrimaryEnemySpinner.random_spin()
				PreparedToReset = false
		elif event.keycode == KEY_P:
			GameProgressProcedure()

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
		GameOverProcedure()
	return

func GameProgressProcedure():
	print("progressing to next encounter")
	StageNumber+=1
	var collectionindex = 0 # Determine which set of enemies should be picked from next (Boss, new level etc.)
	for er in EnemyCollectionBounds:
		if StageNumber >= er.x and StageNumber <= er.y:
			print("now using enemy collection "+ str(collectionindex))
			if ActiveEnemyCollection != collectionindex:
				currentEnemyIndex = -1
				var stagerange = er.y-er.x+1
				print("comparing range of "+str(stagerange)+" to collection size "+str(len(EnemyCollections[ActiveEnemyCollection].Contents)))
				var CountMatchesRange = len(EnemyCollections[ActiveEnemyCollection].Contents) == stagerange
				if CountMatchesRange: # If there is one enemy provided for each stage
					print("Count matches Range "+str(stagerange))
					currentEnemyIndex = -2
			ActiveEnemyCollection = collectionindex
			break
		collectionindex+=1
		
	# LOOT PHASE HERE
	
	PreparedToReset = true
	pass

func GameOverProcedure():
	pass

func AddPoints(amount:int):
	print("earned "+str(abs(amount))+" points")
	PlayerScore+=abs(amount)

func _listener_enemydamaged(healthE:HealthEntity,delta):
	AddPoints(int(ceil(abs(delta))))
	pass
