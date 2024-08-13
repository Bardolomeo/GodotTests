class_name Arrow extends PlayerWeapon

var mouse_pos := Vector2.ZERO
var count := 0
var viewportSize : Vector2
var direction
@export var speed = 400

func _ready():
	hitboxArea = $arrowHitbox
	hitboxShape = $arrowHitbox/arrowCollision
	var charaSprite = $"../CharacterSprite"
	weaponDamage = 5
	hitboxArea.visible = false
	direction = position.direction_to(get_local_mouse_position())
	rotation = get_local_mouse_position().angle()
	
func _process(delta):
		if count < 300:
			position += direction.normalized() * speed * delta
		else:
			queue_free()
		count += 1
