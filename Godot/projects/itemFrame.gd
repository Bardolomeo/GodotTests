extends AnimatedSprite2D

@onready var player = $"../../mainChara"
@onready var ammoCount = $ammoCount
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player.has_bow:
		play("arrow")
		ammoCount.visible = true
		ammoCount.text = "x" + str(player.munitions)
