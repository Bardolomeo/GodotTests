class_name EnemyWeapon extends Area2D


func _ready():
	body_entered.connect(_on_axe_collision)
	
func _on_axe_collision(body: Node):
	if body is Player:
		print("player hit")
