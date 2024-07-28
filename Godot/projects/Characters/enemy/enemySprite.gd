extends AnimatedSprite2D

var fAttack := true
var timer = Timer.new()

func spriteReady():
		play("walk")
		animation_finished.connect(_on_animation_finished)
		animation_changed.connect($"../enemyAP".animationPlayerProcess)

func sprite_process(delta):
	
	if fAttack:
		if $"..".position.x - $"../../mainChara".position.x < 0:
			flip_h = false
		else:
			flip_h = true
	if fAttack and ((abs($"..".position.x - $"../../mainChara".position.x) < 32) and (abs($"..".position.y - $"../../mainChara".position.y) < 32)):
		await get_tree().create_timer(0.1).timeout
		fAttack = false
		play("attack1")
		await get_tree().create_timer(1.0).timeout
		fAttack = true
		
func _on_animation_finished():
	play("walk")
