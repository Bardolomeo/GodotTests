extends AnimationPlayer

var fAttack = false

func _ready():
	pass
# Called when the node enters the scene tree for the first time.
func animationPlayerProcess():
	await get_tree().create_timer(0.1).timeout
	if (!$"..".is_hurt && $"../enemySprite".animation == "attack1" && !fAttack):
		if $"../enemySprite".flip_h == false:
			$"../axeHitbox1".scale.x = 1
		else:
			$"../axeHitbox1".scale.x = -1
		fAttack = true
		play("axeHitbox")
		await animation_finished
		fAttack = false
