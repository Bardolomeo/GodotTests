class_name Enemy extends RigidBody2D

@onready var enemySprite := $enemySprite
@onready var mainChara := $"../mainChara"
@onready var axeHitbox := $axeArea/axeShape
@onready var enemyAnimationPlayer := $enemyAP
@onready var enemyAPinv := $enemyAPinv
@onready var triggerArea := $triggerAttackRadius/triggerAttackRadiusShape
@onready var enemyBodyShape := $enemyBodyShape
@onready var axeArea := $axeArea
@onready var enemyHurtboxShape := $EnemyHurtbox/CollisionShape2D

@export var speed = 100.0
@export var is_enemy = true
@export var hp = 50

var velocity
var body
var fAttack = true
var is_hurt = false
var	is_dead = false


func _ready():
	contact_monitor = true
	max_contacts_reported = 3
	body_entered.connect(_on_body_entered)
	enemyAPinv.animation_finished.connect(_on_APinv_finished)
	


func _physics_process(delta):
	if abs(position.x - mainChara.position.x) > 32.0:
		$enemyNavigationAgent.set_target_position(mainChara.global_position)
	if fAttack == true && !is_hurt && !is_dead:
		await get_tree().process_frame
		if not $enemyNavigationAgent.is_navigation_finished():
			var nextPosition =  $enemyNavigationAgent.get_next_path_position()
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
	axeArea.scale.x = what
	enemyBodyShape.scale.x = what
	$triggerAttackRadius.scale.x = what
		

func _attack():
	fAttack = false
	enemyAnimationPlayer.play("axeHitbox")
	enemySprite.play("attack1")
	
#SIGNALS

func _on_enemy_sprite_animation_finished(anim_name):
	match anim_name:
		"damage":
			set_deferred("is_hurt", false)
		"attack1":
			pass
		"death":
			_death_routine_end()
	set_deferred("is_hurt", false)
	triggerArea.set_deferred("disabled", false)
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
			
	
func _on_body_entered(body: Node):
	pass

func _on_trigger_body_entered(_body : Node2D):
	if _body is Player:
		triggerArea.set_deferred("disabled", true)
		_attack()

#SIGNALS UTILS

func _death_routine_start():
	is_dead = true
	enemySprite.play("death")
	axeHitbox.disabled = true
	triggerArea.disabled = true
	enemyHurtboxShape.disabled = true

func _death_routine_end():
	var boneSprite = Sprite2D.new()
	boneSprite.texture = load("res://Assets/Enemies/bonepile.png")
	boneSprite.position = position
	boneSprite.scale = Vector2(.1, .1)
	$"..".add_child(boneSprite)
	queue_free()


func _on_enemy_navigation_agent_velocity_computed(safe_velocity):
	pass # Replace with function body.
