extends Node

@export var EnemyDisplay:TextureRect
@export var EnemyTitleText:Label
@export var EnemyDescriptionText:Label
@export var EnemyHPSystem:HealthEntity
@export var BackgroundImage:TextureRect

@export var EnemyCollections:Array[EnemyCollection]
@export var EnemyCollectionBounds:Array[Vector2]
@export var ActiveEnemyCollection:int=-2
@export var PrimaryEnemyWheel:Wheel
@export var PrimaryEnemySpinner:Spinner

@export var combatManager:CombatManager
@export var inventoryManager:InvManager
@onready var lootSystem:LootSystem = %LootSystem

@export var progressButton:Button

@export_category("Character LoadIns")
@export var CharFront:TextureRect
@export var CharBack:Sprite2D
@export var CharName:Label
@export var StartingItem:Draggable

var StageNumber:int=-1
var PlayerScore:int=0
var PreparedToStart = true

@export var ScoreLabel:Label

signal combat_ended()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#LoadRandomEnemy()
	CharFront.texture = GlobalChar.char_front
	CharBack.texture = GlobalChar.char_back
	CharName.text = GlobalChar.char_name
	if GlobalChar.starting_item != null:
		StartingItem.item = GlobalChar.starting_item
	StartingItem.manager = inventoryManager
	inventoryManager.wheels[0].UpdateWheel(StartingItem.item)
	inventoryManager.slots[0].equipped_item = StartingItem 
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	ScoreLabel.text = ("Points: "+str(PlayerScore))

var currentEnemyIndex = -1
func LoadNextEnemy():
	print("trying LoadNextEnemy "+str(currentEnemyIndex+1))
	currentEnemyIndex+=1
	var currentcollection = EnemyCollections[ActiveEnemyCollection]
	if CountMatchesRange:
		if len(currentcollection.Contents) <= currentEnemyIndex:
			print("too few items in this collection, defaulting to random pick")
			LoadRandomEnemy()
		else:
			LoadEnemy(currentcollection.Contents[currentEnemyIndex])
	else:
		LoadRandomEnemy()
	
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
	
	if EnemyCollections[ActiveEnemyCollection].Background != null:
		print("loading new background from collection "+str(ActiveEnemyCollection))
		BackgroundImage.texture = EnemyCollections[ActiveEnemyCollection].Background
	ActiveEnemyHP = enemy.BaseHealth
	EnemyHPSystem.isAlive = true
	#EnemyHPSystem.currenthealth = enemy.BaseHealth
	EnemyHPSystem.maxhealth = enemy.BaseHealth
	EnemyHPSystem.sethealth(enemy.BaseHealth)
	
	combatManager.EnemyEntity = EnemyHPSystem
	PrimaryEnemySpinner.modulate = Color.from_hsv(0,0,1)
	EnemyDisplay.modulate = Color.from_hsv(0,0,1)
	
var allowDebug = true
func _input(event: InputEvent) -> void:
	if allowDebug:
		if event is InputEventKey and event.pressed and !event.is_echo():
			if event.keycode == KEY_G:
				if PreparedToContinue:
					PrimaryEnemySpinner.canBeStarted = true
					LoadNextEnemy()
					BeginCombat()
					PreparedToContinue = false
			elif event.keycode == KEY_P:
				GameProgressProcedure()

var PreparedToContinue=false

func EnterLootPhase():
	print("Loot phase")
	lootSystem.spawn_options()

func BeginCombat():
	progressButton.visible = false
	if PreparedToStart:
		PreparedToStart = false
		GameStartProcedure()
		return
	print("begin combat")
	PreparedToContinue = false
	if PrimaryEnemySpinner.isSpinning:
		print("enemy spinner is mid-reset")
		await PrimaryEnemySpinner.spinInterruptComplete
		print("...enemy spinner interrupt is complete")
	PrimaryEnemySpinner.canBeStarted = true
	PrimaryEnemySpinner.random_spin()
	for spinnr in combatManager.PlayerSpinners:
		if spinnr.isResetting:
			await spinnr.spinInterruptComplete
		spinnr.canBeStarted = true
		spinnr.random_spin()

func _listener_entityDied(he:HealthEntity):
	print("entitydied")
	if he == EnemyHPSystem:
		print("active enemy has been killed")
		AddPoints(100)
		PrimaryEnemySpinner.modulate = Color.from_hsv(0,0,0.2)
		PrimaryEnemySpinner.canBeStarted = false
		PrimaryEnemySpinner.InterruptSpin()
		EnemyDisplay.modulate = Color.from_hsv(0,0,0.2)
		combat_ended.emit()
		GameProgressProcedure()
	elif he == combatManager.PlayerEntity:
		print("player has been killed")
		GameOverProcedure()
	return
var CountMatchesRange = false
func UpdateCurrentEnemyCollection():
	var collectionindex = 0 # Determine which set of enemies should be picked from next (Boss, new level etc.)
	for er in EnemyCollectionBounds:
		if StageNumber >= er.x and StageNumber <= er.y:
			print("now using enemy collection "+ str(collectionindex))
			if ActiveEnemyCollection != collectionindex:
				currentEnemyIndex = -1
				var stagerange = er.y-er.x+1
				print("comparing range of "+str(stagerange)+" to collection size "+str(len(EnemyCollections[ActiveEnemyCollection].Contents)))
				CountMatchesRange = len(EnemyCollections[ActiveEnemyCollection].Contents) == stagerange
				if CountMatchesRange: # If there is one enemy provided for each stage
					print("Count matches Range "+str(stagerange))
					#currentEnemyIndex = -1
			ActiveEnemyCollection = collectionindex
			break
		collectionindex+=1
	
func GameProgressProcedure():
	print("loading next encounter")
	StageNumber+=1
	UpdateCurrentEnemyCollection()
	# LOOT PHASE HERE
	EnterLootPhase()
	await lootSystem.loot_ended
	
	#DisplayReadyButton()
	PreparedToContinue = true
	progressButton.visible = true
	LoadNextEnemy()

func GameStartProcedure():
	print("Game Start!")
	StageNumber = 0
	UpdateCurrentEnemyCollection()
	LoadNextEnemy()
	BeginCombat()

func GameOverProcedure():
	pass

func AddPoints(amount:int):
	print("earned "+str(abs(amount))+" points")
	PlayerScore+=abs(amount)

func _listener_enemydamaged(healthE:HealthEntity,delta):
	AddPoints(int(ceil(abs(delta)))*10)
	pass
