extends AnimatedSprite2D


signal current_animation_finished(anim_name)

func _ready():
		play("walk")
		animation_finished.connect(_on_animation_finished)
		current_animation_finished.connect($".."._on_enemy_sprite_animation_finished)
		
func _on_animation_finished():
	emit_signal("current_animation_finished", animation)
