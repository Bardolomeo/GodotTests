class_name Arrow extends PlayerWeapon

var mouse_pos := Vector2.ZERO
var count := 0
var viewportSize : Vector2
var direction
@export var speed = 600

func _ready():
	position = $"../mainChara".position
	hitboxArea = $arrowHitbox
	hitboxShape = $arrowHitbox/arrowCollision
	weaponDamage = 5
	hitboxArea.visible = false
	mouse_pos = get_global_mouse_position()
	direction = position.direction_to(mouse_pos)
	rotation = get_local_mouse_position().angle()
	
func _process(delta):
		if count < 300:
			position += direction.normalized() * speed * delta
		else:
			queue_free()
		count += 1
