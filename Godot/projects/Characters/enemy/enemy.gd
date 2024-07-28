class_name Enemy extends RigidBody2D

@export var velocity = 50.0
@export var is_enemy = true
var is_hurt = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$enemySprite.spriteReady()
	body_entered.connect(_on_body_entered)


func _process(delta):
	$enemySprite.sprite_process(delta)

	if $enemySprite.fAttack == true && !is_hurt:
		if ((abs(position.x - $"../mainChara".position.x) > 32)):
			if position.x - $"../mainChara".position.x < 0:
				position.x += 1.0 * delta * velocity
			else:
				position.x -= 1.0 * delta * velocity
		if (abs(position.y - $"../mainChara".position.y) > 1):
			if position.y  - $"../mainChara".position.y < 0:
				position.y += 1.0 * delta * velocity
			else:
				position.y -= 1.0 * delta * velocity
	

func _on_enemy_sprite_animation_looped():
	$axeHitbox1.visible = false

func _on_body_entered(body: Node):
	if body is Player:
		print("player hit")
