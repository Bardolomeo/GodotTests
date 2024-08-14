class_name CHurtbox extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	area_entered.connect($".."._on_hurtbox_entered)
