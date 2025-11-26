extends Node3D

var time = 0
var checkpoints = 0

var checkpoint_data
var timer_paused = true

@export var bronze_time = 0.0
@export var silver_time = 0.0
@export var gold_time = 0.0

func _process(delta: float) -> void:
	if not timer_paused:
		time = 100000 - $Timer.time_left
	elif $car/car.disable_mode == Node.PROCESS_MODE_DISABLED:
		time = $timer.time_left
func check_checkpoints() -> bool:
	var check = true
	checkpoints = 0
	for i in $checkpoints.get_children():
		check = false if not i.checked else check
		checkpoints = checkpoints + 1 if i.checked else checkpoints
	return check
func finish():
	if check_checkpoints():
		timer_paused = true
		$Timer.stop()
		$car/car.not_finished = false
		$hud.fin()
func save_point():
	checkpoint_data = {
	 "Position": $car/car.position,
	 "Rotation": $car/car.rotation.y,
	 "Speed": $car/car.speed,
	 "Steering": $car/car.steering,
	 "Sliding": $car/car.sliding,
	 "Slide Steer": $car/car.slide_steer,
	 "Drift Boost": $car/car.drift_multiplier,
	 "Velocity": $car/car.velocity
	}

func respawn():
	if $car/car.not_finished:
		$car/car.position = checkpoint_data["Position"]
		$car/car.rotation.y = checkpoint_data["Rotation"]
		$car/car.speed = checkpoint_data["Speed"]
		$car/car.steering= checkpoint_data["Steering"]
		$car/car.sliding= checkpoint_data["Sliding"]
		$car/car.slide_steer= checkpoint_data["Slide Steer"]
		$car/car.drift_multiplier= checkpoint_data["Drift Boost"]
		$car/car.velocity= checkpoint_data["Velocity"]
	else:
		print('retired')
		retire()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("respawn"):
		respawn()
	if Input.is_action_just_pressed("retire"):
		retire()

func retire():
	check_checkpoints()
	for i in $checkpoints.get_children():
		i.checked = false
	$car/car.process_mode = Node.PROCESS_MODE_DISABLED
	$car/car.not_finished = true
	timer_paused = true
	time = 0
	checkpoint_data = {
 "Position": $start.position + Vector3(0,0.5,0),
 "Rotation": $start.rotation.y,
 "Speed": 0,
 "Steering": 0,
 "Sliding": false,
 "Slide Steer": 0,
 "Drift Boost": 0,
 "Velocity": Vector3.ZERO,
	}
	respawn()
	$timer.start()
	
	var checked = 3
	while $timer.time_left != 0:
		if $timer.time_left < 3 and checked == 3:
			checked = 2
			$hud.shown(3)
		if $timer.time_left < 2 and checked == 2:
			checked = 1
			$hud.shown(2)
		if $timer.time_left < 1 and checked == 1:
			checked = 0
			$hud.shown(1)
		await get_tree().process_frame
	$hud.shown(0)
	$Timer.start()
	$car/car.process_mode = Node.PROCESS_MODE_ALWAYS
	$car/car.not_finished = true
	timer_paused = false

func _ready() -> void:
	retire()
