extends Area2D
class_name Player

signal spawn_laser(location)

@onready var muzzle = $Muzzle

var speed = 300

var input_vector = Vector2.ZERO

var hp = 3
var ammo_count = 5
var max_ammo = ammo_count

func _physics_process(delta: float) -> void:
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")

	global_position += input_vector * speed * delta
	
	if Input.is_action_just_pressed("shoot"):
		shoot_laser()
		
		
func take_damage(damage):
	hp -= damage
	if hp<=0:
		queue_free()

func _on_Player_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemies"):
		area.take_damage(1)

func shoot_laser():
	print("shoot pressed")
	print("muzzle global position: ", muzzle.global_position)
	emit_signal("spawn_laser", muzzle.global_position)
