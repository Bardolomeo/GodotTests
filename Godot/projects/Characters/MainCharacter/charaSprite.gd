extends RigidBody2D

@export var velocity = 150.0

# Called when the node enters the scene tree for the first time.
func _ready():
	$"CharacterSprite".play("default")


func _process(delta):
	if Input.is_action_pressed("LeftButton"):
		$AnimationPlayer.play("swordHitbox")
		$CharacterSprite.play("attack1")
		
	if !$CharacterSprite.animation == "attack1":
		if Input.is_action_pressed("Up"):			
			$CharacterSprite.play("walk")
			position += Vector2(0,-1) * delta * velocity
		if Input.is_action_pressed("Down"):
			$CharacterSprite.play("walk")
			position += Vector2(0,1) * delta * velocity
		if Input.is_action_pressed("Left"):
			$CharacterSprite.flip_h = true
			$CharacterSprite.play("walk")
			position += Vector2(-1,0) * delta * velocity
		if Input.is_action_pressed("Right"):
			$CharacterSprite.play("walk")
			$CharacterSprite.flip_h = false
			position += Vector2(1,0) * delta * velocity
	

func _on_character_sprite_animation_looped():
		$CharacterSprite.play("default")
