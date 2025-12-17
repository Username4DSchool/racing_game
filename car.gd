extends CharacterBody3D

@export var speed = 0
@export var steering = 0
@export var sliding = false
@export var slide_steer = 0
@export var drift_multiplier= 0
@export var not_finished = true

func _physics_process(delta: float) -> void:
	if Input.get_axis("ui_left", "ui_right") and speed > 0 and not_finished:
		if speed < 0.2:
			steering = move_toward(steering, Input.get_axis("ui_left", "ui_right"), 0.3 * speed)
		else:
			steering = move_toward(steering, Input.get_axis("ui_left", "ui_right"), 0.2)
	else:
		steering = move_toward(steering, 0, 0.1)
		
	if Input.is_action_pressed("ui_down") and not_finished:
		if Input.is_action_pressed("ui_up"):
			speed = move_toward(speed, 0.3 ,0.018)
		else:
			speed = move_toward(speed, -0.5 ,0.03)
	
	if Input.is_action_just_pressed("ui_down") and not_finished:
		
		if abs(steering) != 0:
			
			sliding = true
			slide_steer = steering / abs(steering)
	
	self.rotate_y(steering * -0.016)
	
	if Input.is_action_pressed("ui_up") and not_finished:
		if speed <= 1:
			speed = move_toward(speed, 1, 0.02)
		else:
			speed = move_toward(speed, 1, 0.004)
	else:
		speed = move_toward(speed, 0, 0.04)
	velocity.y -= 8 * delta
	
	self.move_and_slide()
	self.move_and_collide(Vector3(speed * 30 * delta,0,0).rotated(Vector3(0,1,0), self.rotation.y))
	
	if sliding:
		self.move_and_collide(Vector3(slide_steer * 0.02 * speed, 0 ,0))
		self.rotate_y(slide_steer * -0.008)
		$Node3D.rotation.y = move_toward($Node3D.rotation.y,deg_to_rad(-90) + 0.5 * slide_steer, 0.004)
		$Node3D/Camera3D.fov = move_toward($Node3D/Camera3D.fov, 40, 0.1)
		drift_multiplier += delta * .40
		if steering / abs(steering) != slide_steer or not Input.is_action_pressed("ui_down"):
			sliding = false
			speed = clamp(speed * 1 + drift_multiplier, -1 , 2)
			drift_multiplier = 0
	else:
		$Node3D.rotation.y = move_toward($Node3D.rotation.y,deg_to_rad(-90), 0.04)
		$Node3D/Camera3D.fov = move_toward($Node3D/Camera3D.fov, 75, 01)
