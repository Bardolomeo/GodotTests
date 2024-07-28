class_name PlayerWeapon extends Area2D

var is_enemy = $".".is_enemy
func _ready():
	body_entered.connect(_on_enemy_hit)
	$swordCollision.disabled = true

func _process(delta):
	if Input.is_action_pressed("LeftButton") && !$"..".is_hurt:
			$swordCollision.disabled = false
			if $"../CharacterSprite".flip_h == false:
				scale.x = 1
			else:
				scale.x = -1

func _on_enemy_hit(body: Node):
	if body is Enemy:
		print("enemy hit")
