extends Area2D
class_name Player

signal spawn_laser(location)
signal ammo_changed(current_ammo, max_ammo)
signal reloading_started
signal reloading_finished

@onready var muzzle = $Muzzle

var speed = 300

var input_vector = Vector2.ZERO

var hp = 3

#ammo settings
var ammo = 4
var max_ammo = 4
var reload_time = 1.5
var fire_rate = 0.3

var can_shoot = true
var is_reloading = false

func _ready():
	ammo_changed.emit(ammo, max_ammo)

func _physics_process(delta: float) -> void:
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")

	global_position += input_vector * speed * delta
	
	if Input.is_action_just_pressed("shoot"):
		shoot_laser()
		
	if Input.is_action_just_pressed("reload"):
		reload()
		
func take_damage(damage):
	hp -= damage
	if hp<=0:
		queue_free()

func _on_Player_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemies"):
		area.take_damage(1)

func shoot_laser():
	if not can_shoot:
		return
	if is_reloading:
		return
		
	if ammo <= 0:
		print("out of ammo")
		return
		
	can_shoot = false
	ammo -=1
	ammo_changed.emit(ammo, max_ammo)
	spawn_laser.emit(muzzle.global_position)
	
	#get_tree = get the game
	#.create_timer(n) = make a timer for n seconds
	#.timeout = the signal that fires when the timer is finished
	await get_tree().create_timer(fire_rate).timeout
	can_shoot = true
	
func reload():
	if is_reloading:
		return
	
	if ammo == max_ammo:
		return
	
	is_reloading = true
	reloading_started.emit()
	print("reloading...")
	
	await get_tree().create_timer(reload_time).timeout
	
	ammo = max_ammo
	is_reloading = false
	ammo_changed.emit(ammo, max_ammo)
	reloading_finished.emit()
	
func apply_powerup(powerup_type):
	if powerup_type == "ammo":
		max_ammo += 2
		ammo = max_ammo
		ammo_changed.emit(ammo,max_ammo)
		print("ammo power-up collected")
		
	elif powerup_type == "reload":
		reload_time = max(0.5, reload_time - 0.3)
		print("reload speed power-up collected")
