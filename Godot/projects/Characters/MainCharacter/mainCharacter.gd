class_name Player extends RigidBody2D 

@export var velocity = 150.0
@export var is_player = true
var	is_hurt = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$"CharacterSprite".play("default")


func _process(delta):
	$CharacterSprite.sprite_process()
	$characterAP.animationPlayerProcess()

	if !$CharacterSprite.animation == "attack1" && !is_hurt:
		if Input.is_action_pressed("Up"):			
			position += Vector2(0,-1) * delta * velocity
		if Input.is_action_pressed("Down"):
			position += Vector2(0,1) * delta * velocity
		if Input.is_action_pressed("Left"):
			position += Vector2(-1,0) * delta * velocity
		if Input.is_action_pressed("Right"):
			position += Vector2(1,0) * delta * velocity
	

func _on_character_sprite_animation_looped():
	$CharacterSprite.play("default")

