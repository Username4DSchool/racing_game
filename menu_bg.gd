extends Node3D

func _process(delta: float) -> void:
	$cam.rotation.y += delta * 0.125
