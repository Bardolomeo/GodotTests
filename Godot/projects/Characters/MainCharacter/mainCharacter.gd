class_name Player extends CharacterBody2D 

@onready var charaSprite = $CharacterSprite
@onready var charaAP = $charaAP
@onready var charaAPinv = $charaAPinv
@onready var charaHurtShape = $CharacterHurtbox/CharacterHurtboxShape
@onready var swordHitShape = $sword/swordHitbox1/swordCollision
@onready var charaShape = $CharacterCShape
@onready var arrowScene = preload("res://Characters/MainCharacter/weapons/arrow/arrow.tscn")

@export var is_player = true
@export var hp = 40

var	is_hurt = false
var is_dead = false
var is_busy = false
var has_bow = true

var arrow
var munitions = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2(150 ,150)			
	charaSprite.play("default")


func _physics_process(delta):
	charaSprite.sprite_process()
	charaAP.animationPlayerProcess()

	if (charaSprite.animation == "default" || charaSprite.animation == "walk")  && !is_hurt && !is_dead && !is_busy:
		movement(delta)
	if Input.is_action_pressed("RightButton") && !is_busy && !is_hurt && !is_dead && has_bow:
		ranged_attack()
	if hp <= 0 && !is_dead:
		_death_routine_start()
	

func movement(delta):
	if Input.is_action_pressed("Up"):
		move_and_collide(Vector2(0,-1) * delta * velocity)
	if Input.is_action_pressed("Down"):
		move_and_collide(Vector2(0,1) * delta * velocity)
	if Input.is_action_pressed("Left"):
		move_and_collide(Vector2(-1,0) * delta * velocity)
	if Input.is_action_pressed("Right"):
		move_and_collide(Vector2(1,0) * delta * velocity)

func ranged_attack():
	is_busy = true
	var mousePos = get_global_mouse_position()
	if mousePos.x < global_position.x:
		charaSprite.flip_h = true
	else:
		charaSprite.flip_h = false
	if munitions > 0:
		arrow = arrowScene.instantiate()
		charaSprite.play("ranged")
		munitions -= 1
	else:
		charaSprite.play("ranged_no_ammo")

func _on_character_sprite_animation_looped():
	charaSprite.play("default")
	
func _on_hurtbox_entered(area : Area2D):
	if area is EnemyWeapon:
		charaHurtShape.set_deferred("disabled", true)
		is_hurt = true
		charaSprite.play("damage")
		hp -= area.weaponDamage
		charaAPinv.play("charaAnimLibrary/invulnerability")
	
func _on_chara_sprite_animation_finished(anim_name):
	match anim_name:
			"damage":
				set_deferred("is_hurt", false)
				set_deferred("is_busy", false)
				charaSprite.play("default")
			"ranged":
				set_deferred("is_busy", false)
				charaSprite.play("default")
				add_child(arrow)
			"ranged_no_ammo":
				set_deferred("is_busy", false)
				charaSprite.play("default")

func _on_chara_AP_finished(old_anim):
	match old_anim:
			"charaAnimLibrary/invulnerability":
				if !is_dead:
					charaHurtShape.set_deferred("disabled", false)
	
func _death_routine_start():
	is_dead = true
	z_index = 11
	swordHitShape.set_deferred("disabled", true)
	charaHurtShape.set_deferred("disabled", true)
	charaAPinv.play("RESET")
	charaSprite.stop()
	charaSprite.play("death")
