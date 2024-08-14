extends Enemy

@onready var dynamiteScene = preload("res://Characters/enemy/TNT/projectile/tnt_projectile.tscn")
@onready var playerTooCloseArea = $playerTooCloseArea
var dynamite : Dynamite 
var is_far_enoguh = true


func _ready():
	contact_monitor = true
	max_contacts_reported = 3
	axeHitbox = null
	axeArea = null
	playerTooCloseArea.body_entered.connect(_on_player_too_close)
	playerTooCloseArea.body_exited.connect(_on_player_far_enough)
	enemyAPinv.animation_finished.connect(_on_APinv_finished)
	
func _physics_process(delta):
	$enemyNavigationAgent.set_target_position(mainChara.global_position)
	if fAttack == true && !is_hurt && !is_dead:
		await get_tree().process_frame
		if not $enemyNavigationAgent.is_navigation_finished():
			var nextPosition =  $enemyNavigationAgent.get_next_path_position()
			if !is_far_enoguh:
				velocity = (-nextPosition + global_position).normalized() * delta * speed
			else:
				velocity = (nextPosition - global_position).normalized() * delta * speed
			move_and_collide(velocity)
		if position.x - mainChara.position.x > 0.0:
			flipEnemy(-1.0)
		else:
			flipEnemy(1.0)
		if hp <= 0:
			_death_routine_start()

func flipEnemy(what : float):
	if what > 0:
		enemySprite.flip_h = false
	else:
		enemySprite.flip_h = true
	enemyBodyShape.scale.x = what
	$triggerAttackRadius.scale.x = what
		

func _attack():
	fAttack = false
	enemySprite.play("attack1")
	dynamite = dynamiteScene.instantiate()
	call_deferred("add_child", dynamite)

#SIGNALS

func _on_enemy_sprite_animation_finished(anim_name):
	match anim_name:
		"damage":
			set_deferred("is_hurt", false)
			triggerArea.set_deferred("disabled", false)
		"attack1":
			triggerArea.set_deferred("disabled", false)
			playerTooCloseArea.get_node("CollisionShape2D").set_deferred("disabled", false)
		"death":
			_death_routine_end()
	set_deferred("is_hurt", false)
	fAttack = true
	enemySprite.play("walk")
	
func _on_hurtbox_entered(area : Node):
	if area is PlayerWeaponHitbox && !is_hurt:
		set_deferred("is_hurt", true)
		enemySprite.play("damage")
		hp -= area.weaponDamage
		enemyAnimationPlayer.play("RESET")
		enemyAPinv.play("inv")
		enemyHurtboxShape.set_deferred("disabled", true)
		fAttack = false

func _on_APinv_finished(anim_name):
	match anim_name:
		"inv":
			if !is_dead:
				enemyHurtboxShape.set_deferred("disabled", false)

func _on_trigger_body_entered(sbody : Node2D):
	if sbody is Player and is_far_enoguh and fAttack == true:
		triggerArea.set_deferred("disabled", true)
		playerTooCloseArea.get_node("CollisionShape2D").set_deferred("disabled", true)
		_attack()

func _on_player_too_close(body : Node):
	if body is Player:
		is_far_enoguh = false
		triggerArea.set_deferred("disabled", true)

func _on_player_far_enough(body : Node):
	if body is Player:
		await get_tree().create_timer(1).timeout
		is_far_enoguh = true
		triggerArea.set_deferred("disabled", false)

func _death_routine_start():
	is_dead = true
	enemyAPinv.play("RESET")
	enemySprite.play("death")
	triggerArea.disabled = true
	enemyHurtboxShape.disabled = true
	enemyBodyShape.disabled = true

func _death_routine_end():
	var boneSprite = Sprite2D.new()
	boneSprite.texture = load("res://Assets/Enemies/bonepile.png")
	boneSprite.position = position
	boneSprite.scale = Vector2(.1, .1)
	$"..".add_child(boneSprite)
	queue_free()
