extends AnimatedSprite2D

func _ready():
		animation_finished.connect(_on_animation_finished)
func sprite_process():
	if Input.is_action_pressed("LeftButton") && !$"..".is_hurt:
		play("attack1")

	if !animation == "attack1" && !$"..".is_hurt:
		if Input.is_action_pressed("Up"):			
			play("walk")
		if Input.is_action_pressed("Down"):
			play("walk")
		if Input.is_action_pressed("Left"):
			flip_h = true
			play("walk")
		if Input.is_action_pressed("Right"):
			play("walk")
			flip_h = false

func _on_animation_finished():
	play("default")
