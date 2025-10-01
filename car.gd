extends CharacterBody3D

var speed = 0
var steering = 0

func _physics_process(delta: float) -> void:
	if Input.get_axis("ui_left", "ui_right"):
		if speed < 0.2:
			steering = move_toward(steering, Input.get_axis("ui_left", "ui_right"), 0.1 * speed)
		else:
			steering = move_toward(steering, Input.get_axis("ui_left", "ui_right"), 0.1)
	else:
		steering = move_toward(steering, 0, 0.02)
	self.rotate_y(steering * -0.02)
	if Input.is_action_pressed("ui_up"):
		speed = move_toward(speed, 1, 0.02)
	self.move_and_collide(Vector3(speed * 0.2,0,0).rotated(Vector3(0,1,0), self.rotation.y))
