extends PlayerWeaponHitbox
# Called when the node enters the scene tree for the first time.
func _ready():
	weaponDamage = $"..".weaponDamage
	area_entered.connect(_on_area_entered)

func _on_area_entered(area: Node):
	if area is EnemyHurtbox:
		$"..".queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
