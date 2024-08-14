extends EnemyWeapon
# Called when the node enters the scene tree for the first time.
func _ready():
	weaponDamage = $"..".weaponDamage
	area_entered.connect(_on_area_entered)

func _on_area_entered(area: Node):
	if area is CHurtbox:
		$"..".queue_free()
