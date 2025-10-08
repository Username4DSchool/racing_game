extends CharacterBody3D

var speed = 0
var steering = 0
var sliding = false
var slide_steer = 0
var drift_multiplier= 0
func _physics_process(delta: float) -> void:
	if Input.get_axis("ui_left", "ui_right"):
		if speed < 0.2:
			steering = move_toward(steering, Input.get_axis("ui_left", "ui_right"), 0.1 * speed)
		else:
			steering = move_toward(steering, Input.get_axis("ui_left", "ui_right"), 0.1)
	else:
		steering = move_toward(steering, 0, 0.1)
		
	if Input.is_action_pressed("ui_down"):
		if Input.is_action_pressed("ui_up"):
			speed = move_toward(speed, 0.3 ,0.022)
		else:
			speed = move_toward(speed, -0.5 ,0.03)
	
	if Input.is_action_just_pressed("ui_down"):
		
		if abs(steering) != 0:
			
			sliding = true
			slide_steer = steering / abs(steering)
	
	self.rotate_y(steering * -0.02)
	
	if Input.is_action_pressed("ui_up"):
		if speed <= 1:
			speed = move_toward(speed, 1, 0.02)
		else:
			speed = move_toward(speed, 1, 0.004)
	else:
		speed = move_toward(speed, 0, 0.02)

	self.move_and_collide(Vector3(speed * 0.2,0,0).rotated(Vector3(0,1,0), self.rotation.y))
	print(speed)
	if sliding:
		self.move_and_collide(Vector3(slide_steer * 0.02 * speed, 0 ,0))
		$Node3D.rotation.y = move_toward($Node3D.rotation.y,deg_to_rad(-90) + 0.3 * slide_steer, 0.004)
		$Node3D/Camera3D.fov = move_toward($Node3D/Camera3D.fov, 40, 0.1)
		drift_multiplier += delta * .25
		if steering / abs(steering) != slide_steer or not Input.is_action_pressed("ui_down"):
			sliding = false
			speed = clamp(speed * 1 + drift_multiplier, -1 , 2)
			drift_multiplier = 0
	else:
		$Node3D.rotation.y = move_toward($Node3D.rotation.y,deg_to_rad(-90), 0.04)
		$Node3D/Camera3D.fov = move_toward($Node3D/Camera3D.fov, 75, 01)
