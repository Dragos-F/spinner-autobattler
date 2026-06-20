extends Slice
class_name DamageSlice


@export var value:int = 1 #use positive self for Heal

enum TargetOptions{Self, Enemy}
@export var target:TargetOptions = TargetOptions.Enemy
@export var Crit:bool = false
