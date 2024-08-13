class_name EnemyHurtbox extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	area_entered.connect($".."._on_hurtbox_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
		
