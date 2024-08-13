class_name Enemy extends RigidBody2D

var player
var velocity
var animation_player
var sprite : AnimatedSprite2D
var weaponCollisionBox 

var can_atk = true
var flip_flag = false
@export var speed = 100

func _ready():
	player = $"../mainChara"
	sprite = $enemySprite
	animation_player = $enemyAP
	weaponCollisionBox = $EnemyHurtbox/CollisionShape2D
	$enemySprite.animation_finished.connect(_on_sprite_finished)
	$enemySprite.animation_changed.connect(_on_sprite_changed)

func _process(delta):
	velocity = position.direction_to(player.position).normalized()
	if position.distance_to(player.position) > 32 && can_atk:
		position += velocity
	else:
		if can_atk:
			can_atk = false
			sprite.play("attack1")
		if player.position.x < position.x and !flip_flag:
			scale.x *= -1
			flip_flag = true
		if player.position.x >= position.x and flip_flag:
			scale.x *= -1
			flip_flag = false
	position = position

func _on_sprite_finished():
	if sprite.animation == "attack1":
		$enemyAP/Timer.start(0.7)
		await $enemyAP/Timer.timeout
		can_atk = true
		sprite.play("walk")

func _on_sprite_changed():
	if sprite.animation == "attack1":
		animation_player.play("axeHitbox")
