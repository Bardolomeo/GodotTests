class_name Dynamite extends Node2D

var mouse_pos := Vector2.ZERO
var count := 0
var viewportSize : Vector2
var direction
@onready var hitboxArea = $dynamiteHitbox
@onready var hitboxShape = $dynamiteHitbox/dynamiteCollision
@onready var sprite = $AnimatedSprite2D
@export var weaponDamage = 5
@export var speed = 200

func _ready():
	sprite.play("default")
	hitboxArea.visible = false
	direction = $"..".position.direction_to($"../../mainChara".position)
func _process(delta):
		if count < 300:
			position += direction.normalized() * speed * delta
			if count % 5 == 0:
				rotation -= 5
		else:
			queue_free()
		count += 1
