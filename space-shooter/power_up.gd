extends Area2D

@export var powerup_type = "ammo"

func _on_area_entered(area):
	if area is Player:
		area.apply_powerup(powerup_type)
		queue_free()
		

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
