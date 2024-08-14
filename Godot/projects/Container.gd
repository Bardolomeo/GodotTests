class_name PlayerHealth extends Container

@onready var player :=  $"../../mainChara"
@onready var hearthScene := preload("res://HUD/single_hearth.tscn")

var playerHP
# Called when the node enters the scene tree for the first time.
func _ready():
	playerHealth()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	delta = delta
	playerHealth()	


func playerHealth():
	for child in get_children():
		child.queue_free()
	playerHP = player.hp
	var hp_pos_x = 0
	while playerHP >= 10:
		playerHP -= 10
		var hearth = hearthScene.instantiate()
		hearth.position.x = hp_pos_x
		add_child(hearth)
		hp_pos_x += 60
	if playerHP == 5:
		var hearth = hearthScene.instantiate()
		hearth.position.x = hp_pos_x
		add_child(hearth)
		hearth.play("half_hearth")
		
		
