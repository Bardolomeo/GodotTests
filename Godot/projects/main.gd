extends Node2D

@onready var player := $"mainChara"
var is_death_screen = false
@onready var deathScreenScene = preload("res://HUD/deathScreen.tscn")
var deathScreen
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player.is_dead && !is_death_screen:
		game_over()
		
func game_over():
	is_death_screen = true
	deathScreen = deathScreenScene.instantiate()
	deathScreen.z_index = 10
	$HudCanvas/deathSprite.z_index = 11
	$HudCanvas.add_child(deathScreen)
	$HudCanvas/deathSprite.visible = true
	$HudCanvas/deathSprite.play("death")

