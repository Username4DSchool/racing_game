extends Node3D

var time = 0
var checkpoints = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
func check_checkpoints() -> bool:
	var check = true
	checkpoints = 0
	for i in $checkpoints.get_children():
		check = false if not i.checked else check
		checkpoints = checkpoints + 1 if i.checked else checkpoints
	return check

func finish():
	if check_checkpoints():
		print("finish")
