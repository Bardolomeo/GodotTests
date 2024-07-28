extends AnimationPlayer


# Called when the node enters the scene tree for the first time.
func animationPlayerProcess():
	if Input.is_action_pressed("LeftButton") && !$"..".is_hurt:
		$"../swordHitbox1".visible = true
		play("swordHitbox")
		await animation_finished
		$"../swordHitbox1".visible = false
