extends AnimationPlayer

@onready var swordHitbox = $"../sword/swordHitbox1"

func _ready():
	animation_finished.connect($".."._on_chara_AP_finished)
	$"../charaAPinv".animation_finished.connect($".."._on_chara_AP_finished)
# Called when the node enters the scene tree for the first time.
func animationPlayerProcess():
	if Input.is_action_pressed("LeftButton") && !$"..".is_hurt && !$"..".is_busy:
		swordHitbox.visible = true
		play("swordHitbox")
		await animation_finished
		swordHitbox.visible = false
