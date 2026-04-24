extends Area2D

signal asteroid_destroyed(position)

@export var speed = 80
@export var hp = 5
@export var collision_damage = 5

func _physics_process(delta):
	global_position.y += speed * delta

func take_damage(damage):
	hp -= damage
	
	if hp <= 0:
		asteroid_destroyed.emit(global_position)
		queue_free()

func _on_area_entered(area):
	if area is Player:
		area.take_damage(collision_damage)
		queue_free()

#called when the asteroid leaves the screen
#deletes it when it leaves screen
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
