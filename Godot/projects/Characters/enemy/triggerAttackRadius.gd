extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect($".."._on_trigger_body_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
