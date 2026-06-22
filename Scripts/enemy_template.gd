extends Resource
class_name Enemy
enum EnemyType{
	Standard =0,
	Boss = 1
}

@export var Name:String
@export var BaseHealth:int
@export var Items:Array[WheelItem]
@export var Type:EnemyType
@export var Description:String
@export var Catchphrase:String
@export var Graphic:Texture2D
