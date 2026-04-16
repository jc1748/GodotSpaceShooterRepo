extends Area2D

signal enemy_died

@export() var speed = 150

var hp = 1

func take_damage(damage):
	hp -= damage
	if hp<=0:
		enemy_died.emit()
		queue_free()

func _physics_process(delta):
	global_position.y += speed * delta


func _on_Enemy_area_entered(area):
	if area is Player:
		area.take_damage(1)
