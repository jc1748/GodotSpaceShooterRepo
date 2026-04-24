extends Area2D

var speed = 800

func _ready():
	print("laser ready at: ", global_position)
	visible = true

func _physics_process(delta):
	global_position.y -= speed * delta

func _on_PlayerLaser_area_entered(area: Area2D) -> void:
	#checks if object has this method, instead of only checking one one group
	if area.has_method("take_damage"):
		area.take_damage(1)
		queue_free()
