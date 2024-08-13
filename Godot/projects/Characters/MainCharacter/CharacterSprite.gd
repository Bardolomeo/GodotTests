extends AnimatedSprite2D

signal current_animation_finished(anim_name : String)

func _ready():
		animation_finished.connect(_on_animation_finished)
		current_animation_finished.connect($".."._on_chara_sprite_animation_finished)
func sprite_process():
	if Input.is_action_pressed("LeftButton") && !$"..".is_hurt && !$"..".is_dead && !$"..".is_busy:
		play("attack1")

	if !animation == "attack1" && !$"..".is_hurt && !$"..".is_dead && !$"..".is_busy:
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
	emit_signal("current_animation_finished", animation)
