class_name PlayerWeapon extends Node2D

var hitboxArea
var hitboxShape
@export var weaponDamage = 10

func _ready():
	hitboxArea.visible = false

func _process(delta):
	if Input.is_action_pressed("LeftButton") && !$"..".is_hurt:
			hitboxShape.disabled = false
			if $"../CharacterSprite".flip_h == false:
				scale.x = 1
			else:
				scale.x = -1

func _on_enemy_hit(body: Node):
	if body is Enemy:
		print("enemy hit")
